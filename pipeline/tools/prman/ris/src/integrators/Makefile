CC = g++
CFLAGS = -Wno-deprecated -fPIC -O3
INCLUDES = -I"$(RMANTREE)/include"
LD = $(CC) -shared
SOURCES = PxrDebugShadingContext.cpp PxrDefault.cpp PxrDirectLighting.cpp PxrPathTracer.cpp \
PxrValidateBxdf.cpp PxrVisualizer.cpp PxrOcclusion.cpp
OBJECTS = $(SOURCES:.cpp=.o)
DSO = $(SOURCES:.cpp=.so)
.SUFFIXES: .cpp .o .so

all:  $(OBJECTS) $(DSO)

.o.so: $(OBJECTS)
	$(LD) -o $@ $< 

.cpp.o:
	$(CC) $(INCLUDES) $(CFLAGS) -o $@ -c $<

.PHONY: clean

clean:
	rm -f *.so *.o
