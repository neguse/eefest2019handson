package main

import (
	"fmt"
	"math/rand"
	"sync"
	"time"
)

func sleepRand(msec int) {
	t := rand.Intn(msec)
	time.Sleep(time.Millisecond * time.Duration(t))
}

func execSeq(n int) {
	for i := 0; i < n; i++ {
		sleepRand(1000)
	}
}

func execPar(n int) {
	var wg sync.WaitGroup
	for i := 0; i < n; i++ {
		wg.Add(1)
		go func() {
			sleepRand(1000)
			wg.Done()
		}()
	}
	wg.Wait()
}

func measure(fn func()) int64 {
	t1 := time.Now()
	fn()
	t2 := time.Now()
	return t2.Sub(t1).Nanoseconds()
}

func main() {
	type Ex struct {
		name string
		f    func()
	}
	ex := []Ex{
		Ex{"handson1", func() { sleepRand(1000) }},
		Ex{"handson2", func() { execSeq(10) }},
		Ex{"handson3", func() { execSeq(100) }},
		Ex{"handson4", func() { execPar(10) }},
		Ex{"handson5", func() { execPar(100) }},
		Ex{"handson6", func() { execPar(1000) }},
	}
	for _, e := range ex {
		fmt.Println(e.name, measure(e.f))
	}
}
