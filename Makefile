all: clean

clean: 
	find . -name "*.class" -exec rm -rf {} \;
	find . -name "node_modules" -exec rm -rf {} \;
	
usage:
	du -hs *
