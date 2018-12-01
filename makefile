#############################################################################
#
#    Filename: Makefile
# Description: general makefle for compiling C and C++ source files.
#     License: GPL (General Public License)
#    Modified: wenfu wang (wangwenfu@busap.com)
#        Date: 2012/06/22
#
############################################################################

EXTRA_CFLAGS 	=
EXTRA_LDFLAGS   =
INCLUDE   		= -I$(PWD) 
CPPFLAGS  		= -Wall $(INCLUDE)  -D_LINUX
LDFLAGS   		= -ldl  -lpthread #-lrt -lcrypt 
SRCDIRS   		:= ./
PROGRAM 		= factory

SRCEXTS 		= .cpp
HDREXTS 		= .h
CFLAGS  		= -g -O2
CXXFLAGS 		= -g -O3
CC     			= gcc
CXX 			= g++
RM 				= -rm -f

CTAGS 			= ctags
CTAGSFLAGS 		= -R

# we need't to change it following and can add more for project
ifeq ($(SRCDIRS),)
  SRCDIRS := $(shell find $(SRCDIRS) -type d)
endif
SOURCES = $(foreach d,$(SRCDIRS),$(wildcard $(addprefix $(d)/*,$(SRCEXTS))))
HEADERS = $(foreach d,$(SRCDIRS),$(wildcard $(addprefix $(d)/*,$(HDREXTS))))
SRC_CXX = $(filter-out %.c,$(SOURCES))
OBJS    = $(addsuffix .o, $(basename $(SOURCES)))
DEPS   = $(OBJS:%.o=%.d) #replace %.d with .%.d (hide dependency files)
#DEPS    = $(foreach f, $(OBJS), $(addprefix $(dir $(f))., $(patsubst %.o, %.d, $(notdir $(f)))))

# define variables.
DEP_OPT = $(shell if `$(CC) --version | grep -i "GCC" >/dev/null`; then \
                  echo "-MM"; else echo "-M"; fi )
DEPEND.d    = $(CC)  $(DEP_OPT)  $(EXTRA_CFLAGS) $(CFLAGS) $(CPPFLAGS)
COMPILE.c   = $(CC)  $(EXTRA_CFLAGS) $(CFLAGS)   $(CPPFLAGS) -c
COMPILE.cxx = $(CXX) $(EXTRA_CFLAGS) $(CXXFLAGS) $(CPPFLAGS) -c
LINK.c      = $(CC)  $(EXTRA_CFLAGS) $(CFLAGS)   $(CPPFLAGS) $(LDFLAGS)
LINK.cxx    = $(CXX) $(EXTRA_CFLAGS) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

.PHONY: all objs tags ctags clean distclean help show

# delete the default suffixes
.SUFFIXES:

all: $(PROGRAM)

objs:$(OBJS)
%.o:%.c
	$(COMPILE.c) $< -o $@

%.o:%.C
	$(COMPILE.cxx) $< -o $@

%.o:%.cc
	$(COMPILE.cxx) $< -o $@

%.o:%.cpp
	$(COMPILE.cxx) $< -o $@

%.o:%.CPP
	$(COMPILE.cxx) $< -o $@

%.o:%.c++
	$(COMPILE.cxx) $< -o $@

%.o:%.cp
	$(COMPILE.cxx) $< -o $@

%.o:%.cxx
	$(COMPILE.cxx) $< -o $@

ctags: $(HEADERS) $(SOURCES)
	$(CTAGS) $(CTAGSFLAGS) $(HEADERS) $(SOURCES)

# rules for generating the executable.
$(PROGRAM):$(OBJS)
ifeq ($(SRC_CXX),)              # C program
	$(LINK.c)   $(OBJS) $(EXTRA_LDFLAGS) -o $@
	@echo Type ./$@ to execute the program.
else                            # C++ program
	$(LINK.cxx) $(OBJS) $(EXTRA_LDFLAGS) -o $@
	@echo Type ./$@ to execute the program.
endif

clean:
	$(RM) $(OBJS) $(PROGRAM) $(PROGRAM)
	$(RM) `find . -name ".*.d"` tags

distclean: clean
	$(RM) $(DEPS) TAGS

