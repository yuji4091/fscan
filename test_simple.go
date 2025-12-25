package main

import (
	"fmt"
	"os"
)

func main() {
	fmt.Println("Fscan测试版本 - 验证环境")
	fmt.Printf("参数数量: %d\n", len(os.Args))
	if len(os.Args) > 1 {
		fmt.Printf("参数: %v\n", os.Args[1:])
	}
	fmt.Println("程序可以正常运行！")
}