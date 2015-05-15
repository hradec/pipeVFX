/*
Shave and a Haircut emulation shader (c) 2010 Joe Alter, Inc
by Joe Alter
Illuminance fixes by Bernard Edlington, updated by David Lin, AOVs and secondary spec by John Helms

Last updated: 03/08/2012
*/

normal pxslUtilShadingNormal(normal n;) {
	normal Ns = normalize(n);
	extern vector I;
	uniform float sides = 2;
	uniform float raydepth;
	attribute("Sides", sides);
	rayinfo("depth", raydepth);
	if (sides == 2 || raydepth > 0) Ns = faceforward(Ns, I, Ns);
	return Ns;
}

surface Shave (
	float Ka = 0, 
		SHAVEambdiff = 0.6, 
		SHAVEspec = 0.35, 
		SHAVEgloss = 0.07,
		SHAVEopacity = 1,
		SHAVEselfshad=1,
		coneangle = 30; /* note to Joe: this parameter should be converted from the SHAVEgloss primvar */
	color SHAVEspec_color=1,
		SHAVEspec_color2 = 1,
		rootcolor=1,
		tipcolor=1;

/* AOVs commented ones not yet supported */
	output varying 
	color Ambient=0,
//		Backscattering=0,
		DiffuseColor=0,
		DiffuseDirect=0,
		DiffuseDirectShadow=0,
		DiffuseEnvironment=0,
		DiffuseIndirect=0,
//		Incandescence=0,
		OcclusionDirect=0,
		OcclusionIndirect=0,
//		Refraction=0,
//		Rim=0,
		SpecularColor=0,
		SpecularDirect=0,
		SpecularDirectShadow=0;
//		SpecularEnvironment=0,
//		SpecularIndirect=0,
//		Subsurface=0,
//		Translucence=0;
)
{ 

	normal Ns = pxslUtilShadingNormal(N);
	normal Nn = normalize(N);
	vector In = normalize(I);

	// secondary spec variables
	float bendTangentAmt = 0.35;		/* use values between 0 and 1, less than 0 is off */
	float secondarySHAVEglossMult = 0.7; /* multiply SHAVEgloss for secondary spec gloss value, less than 1.0 is more broad */

	vector T = normalize (dPdv), 	/* tangent along length of hair */
//		Tu = normalize (mix(dPdv,-vector(-Nn),bendTangentAmt)), 	/* bent tangent up along length of hair */
		V = -normalize(I), 			/* V is the view vector */
		Tu = normalize (mix(dPdv,-vector(V),bendTangentAmt)); 	/* bent tangent up along length of hair */

	float diffK = 0,
		VdotT = V . T,
		VdotTSq = VdotT * VdotT,
		sq2 = 1;

	float VdotTu = V . Tu,
		VdotTSqU = VdotTu * VdotTu,
		sq3 = 1;

	varying color Clocal = color(1,1,1),
		inshadow,
		Cl_noshd,
		Cl_diff;

	color SpecularDirectD = 0,
		SpecularDirectU = 0,
		SpecularDirectShadowD = 0,
		SpecularDirectShadowU = 0;

	if(VdotTSq < 1)
	sq2 = sqrt(1 - VdotTSq);

	if(VdotTSqU < 1)
	sq3 = sqrt(1 - VdotTSqU);

	// illumination from direct lights
	// here we:
	// - add to our total diffuse contribution
	// - tally direct occlusion (shadow)
	// - tally (unoccluded) direct illumination
	illuminance(P) //, "lightcache", "reuse")
	{
		vector	Ln = normalize(L);
		float	nondiff = 0, rawDiff, rawDiffu;
		color	Cselfshad;

		Cselfshad = Cl * SHAVEselfshad + (1 - SHAVEselfshad);

//		lightsource("__nondiffuse", nondiff);
//		if (nondiff < 1)
		{
			rawDiff = 1;//(1-nondiff) * sqrt(1 - pow((T . Ln), 2));
			rawDiffu = 1;//(1-nondiff) * sqrt(1 - pow((Tu . Ln), 2));
			diffK = mix(1, rawDiff, SHAVEambdiff);

			if( 0 != lightsource("_shadow", inshadow) )
			OcclusionDirect += inshadow;
			if( 0 == lightsource("_cl_noshadow", Cl_noshd) )
			Cl_noshd = Cselfshad;
			Cl_diff = Cl_noshd - Cselfshad;
			DiffuseDirect += diffK;// * Cl_noshd;
			DiffuseDirectShadow += diffK;// * Cl_diff;
		}

		float nonspec = 0;
		color inshadow = 0, Cl_noshd = 0, Cl_diff;
//		lightsource("__nonspecular", nonspec);
//		if (nonspec < 1)
		{
			float specK = (1-nonspec) * rawDiff * sq2 - (Ln . T ) * VdotT;
			specK = pow (specK, 1 / ( 1 * ( 0.101 - SHAVEgloss ) ) );// * 0.5;

			float specK2 = (1-nonspec) * rawDiffu * sq3 - (Ln . Tu ) * VdotTu;
			specK2 = pow (specK2, 1 / ( 1 * ( 0.101 - (SHAVEgloss*secondarySHAVEglossMult) ) ) );// * 0.5;

			if( 0 != lightsource("_shadow", inshadow) )
			OcclusionDirect += inshadow;
			if( 0 == lightsource("_cl_noshadow", Cl_noshd) )
			Cl_noshd = Cselfshad;
			Cl_diff = Cl_noshd - Cselfshad;

			SpecularDirectD += specK * Cl_noshd;
			SpecularDirectShadowD += specK * Cl_diff;
			
			SpecularDirectU += specK2 * Cl_noshd;
			SpecularDirectShadowU += specK2 * Cl_diff;			
		}
	}

	// illumination from environments
	// this will include both environment and indirect illum
	float occl = 0;
	color indiff = color(0);
	color envcolor = color(0);
	color speccolor = color(0);

	// get all envlights
	shader envlights[] = getlights("category", "environment");
	uniform float i, n = arraylength(envlights);

	// for specular calculations
	vector envdir = reflect(In, Nn);
	float angle = radians(coneangle);

	for(i=0;i<n;i+=1) // Loop through each envlight
	{
		//Diffuse contributions from EnvLight
		envlights[i]->diffuseIllum(P, Ns, Nn, indiff, envcolor, envdir, occl);
		occl=SHAVEselfshad*occl+(1.0-SHAVEselfshad);
		color env = envcolor * (1-occl);
		DiffuseIndirect += indiff - env;
		DiffuseEnvironment += env;

		//Specular contributions from EnvLight
		//envlights[i]->specularIllum(P, envdir, angle, speccolor);
		//SpecularEnvironment += speccolor;
	}

	Clocal = mix( rootcolor, tipcolor, v );
	Oi = Os*SHAVEopacity;
	//color radiosity = Oi * Clocal * (DiffuseDirect - DiffuseDirectShadow + DiffuseEnvironment + DiffuseIndirect);
	color radiosity = Clocal * (DiffuseDirect - DiffuseDirectShadow + DiffuseEnvironment + DiffuseIndirect);

	// find out if it's a bake pass
	string CurrentPassClass = "";
	option("user:pass_class",  CurrentPassClass);

	// calculate area for occlusion baking
	float a = area(P, "dicing");

	// If is a bake pass
	if (CurrentPassClass == "RenderRadiosity" && a > 0)
	{
		for(i=0;i<n;i+=1) // Loop through each envlight
		{
		envlights[i]->bake(P, Nn, a, radiosity, Clocal);
		}
	}

//	Clocal *= Cs;

	// AOVs

	if (bendTangentAmt >= 0)
	{
		SpecularDirect = max((SpecularDirectD * SHAVEspec_color * SHAVEspec),
			(SpecularDirectU * SHAVEspec_color2 * SHAVEspec));
		SpecularDirectShadow = 	max((SpecularDirectShadowD * SHAVEspec_color * SHAVEspec),
			(SpecularDirectShadowU * SHAVEspec_color2 * SHAVEspec));
	}
	else
	{
		SpecularDirect = SpecularDirectD * SHAVEspec_color * SHAVEspec;
		SpecularDirectShadow = SpecularDirectShadowD * SHAVEspec_color * SHAVEspec;
	}
    
    {
    color cc=mix( rootcolor, tipcolor, v );;
    
	Ambient = cc * Ka * ambient();
	OcclusionIndirect += occl;
	DiffuseColor = cc;
	DiffuseDirect *= cc;
	DiffuseDirectShadow *= cc;
	DiffuseEnvironment *= cc;
	DiffuseIndirect *= cc;
    }
	// Note Oi does not affect specular. - no no, it should (joe)
	if(Oi != color(1)) {
	Ambient *= Oi;
	SpecularDirect*=Oi;
	SpecularDirectShadow*=Oi;
	OcclusionIndirect *= Oi;
	DiffuseDirect *= Oi;
	DiffuseDirectShadow *= Oi;
	DiffuseEnvironment *= Oi;
	DiffuseIndirect *= Oi;
	}

	Ci = Ambient + 
	DiffuseDirect - DiffuseDirectShadow +
	SpecularDirect - SpecularDirectShadow +
	DiffuseEnvironment + DiffuseIndirect;
    
    Ci = DiffuseColor;//Cs * mix( rootcolor, tipcolor, v );;
}
