# Makefile 
#
CXX = g++
MPICXX = mpicxx 
CUDAXX = nvcc 
CUDAFLAGS = -x cu -arch=sm_20 -dc -lineinfo
CUDALFLAGS = -arch=sm_20 
CXXFLAGS = -std=c++17 -g -Wall 
#--compiler-options -Wall
LINKFLAGS = -std=c++17 -g
LIBDIRS = -L/usr/local/lib
LDFLAGS = -lnetcdf -lhdf5_hl -lhdf5 -lcurl -lm -lz -ldl 
#LDFLAGS = -lpnetcdf -lnetcdf -lhdf5_hl -lhdf5 -lm -lz -ldl -lmpi -lmpicxx
INCDIRS = -I/usr/local/include
TARGET = ensland
CXX_SRCS = main.cpp ensland.cpp ncfuncs.cpp 
OBJS = $(CXX_SRCS:.cpp=.o)

$(TARGET) : $(OBJS)
	$(MPICXX) $(LINKFLAGS) -o $@ $^ $(LIBDIRS) $(LDFLAGS)
#$(CUDAXX) $(CUDALFLAGS) $(LINKFLAGS) -o $@ $^ $(LIBDIRS) $(LDFLAGS)

%.o : %.cpp
	$(MPICXX) $(CXXFLAGS) $(INCDIRS) -c $< 

clean :
	$(RM) $(OBJS) $(TARGET)