println(ARGS)

num = ARGS[1]
open("/archive/controller/results/result_"*num, "w")  do fp
    write(fp, "sample text\n")
end
