package bico64

import "core:slice"

Register :: enum u8 {
  zero,
  ra,
  sp,
  gp,
  tp,
  t0,
  t1,
  t2,
  s0,
  s1,
  a0,
  a1,
  a2,
  a3,
  a4,
  a5,
  a6,
  a7,
  s2,
  s3,
  s4,
  s5,
  s6,
  s7,
  s8,
  s9,
  s10,
  s11,
  t3,
  t4,
  t5,
  t6,
}

IntegerReg :: struct #raw_union {
  u: u64,
  i: i64
}

FloatReg :: struct #raw_union {
  s: f32,
  d: f64
}

Machine :: struct {
  x: [32]IntegerReg,
  f: [32]FloatReg,
  pc: u64,
  memory: []u8, // 1 megabyte
}

init_machine :: proc(m: ^Machine, program: []u32) {
  assert(size_of(m.memory) >= size_of(program))
  
  fixed_prog := slice.reinterpret([]u8, program)
  copy_slice(m.memory, fixed_prog) // copy(mem[:], program[:])
  print_prog_mem(m)
  
  m.pc = 0 // start at first instruction
}