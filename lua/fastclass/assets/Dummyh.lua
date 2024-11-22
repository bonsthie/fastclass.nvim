return [[#ifndef __DUMMY__
# define __DUMMY__

class Dummy {
	public:
	Dummy(const Dummy &ref);
	Dummy(void);
	~Dummy(void);

	Dummy &operator=(Dummy const &src);
};

#endif /* __DUMMY__ */]]
