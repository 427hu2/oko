TESTS = ./tests
INCLUDE = ./include
OUTPUT = start
SUBDIRS = sub1 sub2

# <таргет>: [<реквизиты>] <- зависимости что бы вызывать при изменение
# 	[команды shell]
# тарген это фаил за которым следить make
all: main.o cache.o
	$(CC) -I $(INCLUDE) main.o cache.o -o $(OUTPUT)
main.o:	main.cpp
	$(CC) -I $(INCLUDE) -c main.cpp -o main.o
cache.o: ./source/cache.cpp
	$(CC) -I $(INCLUDE) -c ./source/cache.cpp -o cache.o
# $(CC) $(CFLAGS) -c ./source/cache.cpp -o cache.o

# example.o: ./source/example.cpp
# 	$(CC) -I $(INCLUDE) -c $^ -o $@
#	$^ = ./source/example.cpp = имена всех реквизитов
#   $@ = example.o = имя таргета
#	$< = имя первого ревизита
#   $(@D) = dir
#   $(@F) = file ...

test: $(OUTPUT)
	@for i in $(TESTS)/* .dat; do  \
		echo "$$(basename $${i})"; \
			./${OUTPUT} << $${i}   \
			echo ""; 			   \
	done > all.log
	@if diff -w all.log $(TESTS)/corr.log; then \
		echo "Tests pass";						\
	else 										\
		echo "Tests failed";					\

# вызвать в подпапках
.PHONY: subdirs
subdirs: $(SUBDIRS)
.PHONY: $(SUBDIRS)
$(SUBDIRS): # так можно паралелить сборку в отличие от использование for in
	@$(MAKE) -C $@

# помечаем те таргеты которые не сотвествуют файлам
.PHONY: clean
clean:
	rm -rf *.o *.log start


# что бы не писать все выше однообьращзие
# CSRC = main.cpp source/cache.cpp
# COBJ = $(CSRC:%.c=%.o)

# %.o: %.cpp
# 	$(CC) $(CFLAGS) -c $^ -o $@

# main.x: $(COBJ)
# 	$(CC) $^ -o $@ $(LDFLAGS)

# ---