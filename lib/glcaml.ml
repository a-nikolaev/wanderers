(*
 * GLCaml - Objective Caml interface for OpenGL 1.1, 1.2, 1.3, 1.4, 1.5, 2.0 and 2.1
 * plus extensions: 
 * 
 * Copyright (C) 2007, 2008 Elliott OTI
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided 
 * that the following conditions are met:
 *  - Redistributions of source code must retain the above copyright notice, this list of conditions 
 *    and the following disclaimer.
 *  - Redistributions in binary form must reproduce the above copyright notice, this list of conditions 
 *    and the following disclaimer in the documentation and/or other materials provided with the distribution.
 *  - The name Elliott Oti may not be used to endorse or promote products derived from this software 
 *    without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * 'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)


(** 1-dimensional array definitions for 
	- 8-bit signed bytes
	- 8-bit unsigned bytes
	- 16 bits signed words
	- 16 bits unsigned words
	- 32 bit signed words
	- 64 bit signed words
	- native word size
	- 32 bit IEEE floats 
	- 64 bit IEEE floats *)
type byte_array = (int, Bigarray.int8_signed_elt, Bigarray.c_layout) Bigarray.Array1.t
type ubyte_array = (int, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
type short_array = (int, Bigarray.int16_signed_elt, Bigarray.c_layout) Bigarray.Array1.t
type ushort_array = (int, Bigarray.int16_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
type word_array = (int32, Bigarray.int32_elt, Bigarray.c_layout) Bigarray.Array1.t
type dword_array = (int64, Bigarray.int64_elt, Bigarray.c_layout) Bigarray.Array1.t
type int_array = (int, Bigarray.int_elt, Bigarray.c_layout) Bigarray.Array1.t
type float_array = (float, Bigarray.float32_elt, Bigarray.c_layout) Bigarray.Array1.t
type double_array = (float, Bigarray.float64_elt, Bigarray.c_layout) Bigarray.Array1.t

(** 2-dimensional array definitions for 
	- 8-bit signed bytes
	- 8-bit unsigned bytes
	- 16 bits signed words
	- 16 bits unsigned words
	- 32 bit signed words
	- 64 bit signed words
	- native word size
	- 32 bit IEEE floats 
	- 64 bit IEEE floats *)
type byte_matrix = (int, Bigarray.int8_signed_elt, Bigarray.c_layout) Bigarray.Array2.t
type ubyte_matrix = (int, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array2.t
type short_matrix = (int, Bigarray.int16_signed_elt, Bigarray.c_layout) Bigarray.Array2.t
type ushort_matrix = (int, Bigarray.int16_unsigned_elt, Bigarray.c_layout) Bigarray.Array2.t
type word_matrix = (int32, Bigarray.int32_elt, Bigarray.c_layout) Bigarray.Array2.t
type dword_matrix = (int64, Bigarray.int64_elt, Bigarray.c_layout) Bigarray.Array2.t
type int_matrix = (int, Bigarray.int_elt, Bigarray.c_layout) Bigarray.Array2.t
type float_matrix = (float, Bigarray.float32_elt, Bigarray.c_layout) Bigarray.Array2.t
type double_matrix = (float, Bigarray.float64_elt, Bigarray.c_layout) Bigarray.Array2.t

(** Create 1-dimensional arrays of the following types:
	- 8-bit signed bytes
	- 8-bit unsigned bytes
	- 16 bits signed words
	- 16 bits unsigned words
	- 32 bit signed words
	- 64 bit signed words
	- native word size
	- 32 bit IEEE floats 
	- 64 bit IEEE floats *)
let make_byte_array len = Bigarray.Array1.create Bigarray.int8_signed Bigarray.c_layout len
let make_ubyte_array len = Bigarray.Array1.create Bigarray.int8_unsigned Bigarray.c_layout len
let make_short_array len = Bigarray.Array1.create Bigarray.int16_signed Bigarray.c_layout len
let make_ushort_array len = Bigarray.Array1.create Bigarray.int16_unsigned Bigarray.c_layout len
let make_word_array len = Bigarray.Array1.create Bigarray.int32 Bigarray.c_layout len
let make_dword_array len = Bigarray.Array1.create Bigarray.int64 Bigarray.c_layout len
let make_int_array len = Bigarray.Array1.create Bigarray.int Bigarray.c_layout len
let make_float_array len = Bigarray.Array1.create Bigarray.float32 Bigarray.c_layout len
let make_double_array len = Bigarray.Array1.create Bigarray.float64 Bigarray.c_layout len

(** Create 2-dimensional arrays of the following types:
	- 8-bit signed bytes
	- 8-bit unsigned bytes
	- 16 bits signed words
	- 16 bits unsigned words
	- 32 bit signed words
	- 64 bit signed words
	- native word size
	- 32 bit IEEE floats 
	- 64 bit IEEE floats *)
let make_byte_matrix dim1 dim2 = Bigarray.Array2.create Bigarray.int8_signed Bigarray.c_layout  dim1 dim2
let make_ubyte_matrix dim1 dim2 = Bigarray.Array2.create Bigarray.int8_unsigned Bigarray.c_layout  dim1 dim2
let make_short_matrix dim1 dim2 = Bigarray.Array2.create Bigarray.int16_signed Bigarray.c_layout  dim1 dim2
let make_ushort_matrix dim1 dim2 = Bigarray.Array2.create Bigarray.int16_unsigned Bigarray.c_layout  dim1 dim2
let make_word_matrix dim1 dim2 = Bigarray.Array2.create Bigarray.int32 Bigarray.c_layout  dim1 dim2
let make_dword_matrix dim1 dim2 = Bigarray.Array2.create Bigarray.int64 Bigarray.c_layout  dim1 dim2
let make_int_matrix dim1 dim2 = Bigarray.Array2.create Bigarray.int Bigarray.c_layout  dim1 dim2
let make_float_matrix dim1 dim2 = Bigarray.Array2.create Bigarray.float32 Bigarray.c_layout  dim1 dim2
let make_double_matrix dim1 dim2 = Bigarray.Array2.create Bigarray.float64 Bigarray.c_layout  dim1 dim2

(** Conversions between native Ocaml arrays and bigarrays for
	- int arrays to byte_arrays
	- int arrays to ubyte_arrays
	- int arrays to short_arrays
	- int arrays to ushort_arrays
	- int arrays to int_arrays
	- float arrays to float_arrays
	- float arrays to double_arrays
*)
let to_byte_array a = Bigarray.Array1.of_array Bigarray.int8_signed Bigarray.c_layout a
let to_ubyte_array a = Bigarray.Array1.of_array Bigarray.int8_unsigned Bigarray.c_layout a
let to_short_array a = Bigarray.Array1.of_array Bigarray.int16_signed Bigarray.c_layout a
let to_ushort_array a = Bigarray.Array1.of_array Bigarray.int16_unsigned Bigarray.c_layout a
let to_word_array a = 
	let r = make_word_array (Array.length a) in
	let _ = Array.iteri (fun i a -> r.{i} <- Int32.of_int a ) a in r
let to_dword_array a = 
	let r = make_dword_array (Array.length a) in
	let _ = Array.iteri (fun i a -> r.{i} <- Int64.of_int a ) a in r
let to_int_array a = 
	let r = make_int_array (Array.length a) in
	let _ = Array.iteri (fun i a -> r.{i} <- a ) a in r
let to_float_array a = 
	let r = make_float_array (Array.length a) in
	let _ = Array.iteri (fun i a -> r.{i} <- a ) a in r
let to_double_array a = 
	let r = make_double_array (Array.length a) in
	let _ = Array.iteri (fun i a -> r.{i} <- a ) a in r

(**	Copy data between bigarrays and preallocated Ocaml arrays of 
	suitable length:
	- byte_array to int array
	- ubyte_array to int array
	- short_array to int array
	- ushort_array to int array
	- word_array to int array
	- dword_array to int array
	- float_array to float array
	- double_array to float array
*)
let copy_byte_array src dst =
	Array.iteri (fun i c -> dst.(i) <- src.{i} ) dst
let copy_ubyte_array = copy_byte_array
let copy_short_array = copy_byte_array
let copy_ushort_array = copy_byte_array
let copy_word_array src dst =
	Array.iteri (fun i c -> dst.(i) <- Int32.to_int src.{i} ) dst
let copy_dword_array src dst =
	Array.iteri (fun i c -> dst.(i) <- Int64.to_int src.{i} ) dst
let copy_float_array src dst = copy_byte_array	
let copy_double_array src dst = copy_byte_array	

(** Convert a byte_array or ubyte_array to a string *)
let to_string a =
	let l = Bigarray.Array1.dim a in
	let s = String.create l in
	for i = 0 to (l - 1) do
		s.[i] <- a.{i}
	done;
	s

(** Convert between booleans and ints *)
let int_of_bool b = if b then 1 else 0
let bool_of_int i = not (i = 0)
let bool_to_int_array b = Array.map int_of_bool b
let int_to_bool_array i = Array.map bool_of_int i
let copy_to_bool_array src dst = 
	Array.mapi (fun i c -> dst.(i) <-  bool_of_int src.(i)) dst



let gl_constant_color = 0x00008001
let gl_one_minus_constant_color = 0x00008002
let gl_constant_alpha = 0x00008003
let gl_one_minus_constant_alpha = 0x00008004
let gl_blend_color = 0x00008005
let gl_func_add = 0x00008006
let gl_min = 0x00008007
let gl_max = 0x00008008
let gl_blend_equation = 0x00008009
let gl_func_subtract = 0x0000800a
let gl_func_reverse_subtract = 0x0000800b
let gl_convolution_1d = 0x00008010
let gl_convolution_2d = 0x00008011
let gl_separable_2d = 0x00008012
let gl_convolution_border_mode = 0x00008013
let gl_convolution_filter_scale = 0x00008014
let gl_convolution_filter_bias = 0x00008015
let gl_reduce = 0x00008016
let gl_convolution_format = 0x00008017
let gl_convolution_width = 0x00008018
let gl_convolution_height = 0x00008019
let gl_max_convolution_width = 0x0000801a
let gl_max_convolution_height = 0x0000801b
let gl_post_convolution_red_scale = 0x0000801c
let gl_post_convolution_green_scale = 0x0000801d
let gl_post_convolution_blue_scale = 0x0000801e
let gl_post_convolution_alpha_scale = 0x0000801f
let gl_post_convolution_red_bias = 0x00008020
let gl_post_convolution_green_bias = 0x00008021
let gl_post_convolution_blue_bias = 0x00008022
let gl_post_convolution_alpha_bias = 0x00008023
let gl_histogram = 0x00008024
let gl_proxy_histogram = 0x00008025
let gl_histogram_width = 0x00008026
let gl_histogram_format = 0x00008027
let gl_histogram_red_size = 0x00008028
let gl_histogram_green_size = 0x00008029
let gl_histogram_blue_size = 0x0000802a
let gl_histogram_alpha_size = 0x0000802b
let gl_histogram_luminance_size = 0x0000802c
let gl_histogram_sink = 0x0000802d
let gl_minmax = 0x0000802e
let gl_minmax_format = 0x0000802f
let gl_minmax_sink = 0x00008030
let gl_table_too_large = 0x00008031
let gl_color_matrix = 0x000080b1
let gl_color_matrix_stack_depth = 0x000080b2
let gl_max_color_matrix_stack_depth = 0x000080b3
let gl_post_color_matrix_red_scale = 0x000080b4
let gl_post_color_matrix_green_scale = 0x000080b5
let gl_post_color_matrix_blue_scale = 0x000080b6
let gl_post_color_matrix_alpha_scale = 0x000080b7
let gl_post_color_matrix_red_bias = 0x000080b8
let gl_post_color_matrix_green_bias = 0x000080b9
let gl_post_color_matrix_blue_bias = 0x000080ba
let gl_post_color_matrix_alpha_bias = 0x000080bb
let gl_color_table = 0x000080d0
let gl_post_convolution_color_table = 0x000080d1
let gl_post_color_matrix_color_table = 0x000080d2
let gl_proxy_color_table = 0x000080d3
let gl_proxy_post_convolution_color_table = 0x000080d4
let gl_proxy_post_color_matrix_color_table = 0x000080d5
let gl_color_table_scale = 0x000080d6
let gl_color_table_bias = 0x000080d7
let gl_color_table_format = 0x000080d8
let gl_color_table_width = 0x000080d9
let gl_color_table_red_size = 0x000080da
let gl_color_table_green_size = 0x000080db
let gl_color_table_blue_size = 0x000080dc
let gl_color_table_alpha_size = 0x000080dd
let gl_color_table_luminance_size = 0x000080de
let gl_color_table_intensity_size = 0x000080df
let gl_ignore_border = 0x00008150
let gl_constant_border = 0x00008151
let gl_wrap_border = 0x00008152
let gl_replicate_border = 0x00008153
let gl_convolution_border_color = 0x00008154
let gl_matrix_palette_arb = 0x00008840
let gl_max_matrix_palette_stack_depth_arb = 0x00008841
let gl_max_palette_matrices_arb = 0x00008842
let gl_current_palette_matrix_arb = 0x00008843
let gl_matrix_index_array_arb = 0x00008844
let gl_current_matrix_index_arb = 0x00008845
let gl_matrix_index_array_size_arb = 0x00008846
let gl_matrix_index_array_type_arb = 0x00008847
let gl_matrix_index_array_stride_arb = 0x00008848
let gl_matrix_index_array_pointer_arb = 0x00008849
let gl_texture0_arb = 0x000084c0
let gl_texture1_arb = 0x000084c1
let gl_texture2_arb = 0x000084c2
let gl_texture3_arb = 0x000084c3
let gl_texture4_arb = 0x000084c4
let gl_texture5_arb = 0x000084c5
let gl_texture6_arb = 0x000084c6
let gl_texture7_arb = 0x000084c7
let gl_texture8_arb = 0x000084c8
let gl_texture9_arb = 0x000084c9
let gl_texture10_arb = 0x000084ca
let gl_texture11_arb = 0x000084cb
let gl_texture12_arb = 0x000084cc
let gl_texture13_arb = 0x000084cd
let gl_texture14_arb = 0x000084ce
let gl_texture15_arb = 0x000084cf
let gl_texture16_arb = 0x000084d0
let gl_texture17_arb = 0x000084d1
let gl_texture18_arb = 0x000084d2
let gl_texture19_arb = 0x000084d3
let gl_texture20_arb = 0x000084d4
let gl_texture21_arb = 0x000084d5
let gl_texture22_arb = 0x000084d6
let gl_texture23_arb = 0x000084d7
let gl_texture24_arb = 0x000084d8
let gl_texture25_arb = 0x000084d9
let gl_texture26_arb = 0x000084da
let gl_texture27_arb = 0x000084db
let gl_texture28_arb = 0x000084dc
let gl_texture29_arb = 0x000084dd
let gl_texture30_arb = 0x000084de
let gl_texture31_arb = 0x000084df
let gl_active_texture_arb = 0x000084e0
let gl_client_active_texture_arb = 0x000084e1
let gl_max_texture_units_arb = 0x000084e2
let gl_max_vertex_units_arb = 0x000086a4
let gl_active_vertex_units_arb = 0x000086a5
let gl_weight_sum_unity_arb = 0x000086a6
let gl_vertex_blend_arb = 0x000086a7
let gl_current_weight_arb = 0x000086a8
let gl_weight_array_type_arb = 0x000086a9
let gl_weight_array_stride_arb = 0x000086aa
let gl_weight_array_size_arb = 0x000086ab
let gl_weight_array_pointer_arb = 0x000086ac
let gl_weight_array_arb = 0x000086ad
let gl_modelview0_arb = 0x00001700
let gl_modelview1_arb = 0x0000850a
let gl_modelview2_arb = 0x00008722
let gl_modelview3_arb = 0x00008723
let gl_modelview4_arb = 0x00008724
let gl_modelview5_arb = 0x00008725
let gl_modelview6_arb = 0x00008726
let gl_modelview7_arb = 0x00008727
let gl_modelview8_arb = 0x00008728
let gl_modelview9_arb = 0x00008729
let gl_modelview10_arb = 0x0000872a
let gl_modelview11_arb = 0x0000872b
let gl_modelview12_arb = 0x0000872c
let gl_modelview13_arb = 0x0000872d
let gl_modelview14_arb = 0x0000872e
let gl_modelview15_arb = 0x0000872f
let gl_modelview16_arb = 0x00008730
let gl_modelview17_arb = 0x00008731
let gl_modelview18_arb = 0x00008732
let gl_modelview19_arb = 0x00008733
let gl_modelview20_arb = 0x00008734
let gl_modelview21_arb = 0x00008735
let gl_modelview22_arb = 0x00008736
let gl_modelview23_arb = 0x00008737
let gl_modelview24_arb = 0x00008738
let gl_modelview25_arb = 0x00008739
let gl_modelview26_arb = 0x0000873a
let gl_modelview27_arb = 0x0000873b
let gl_modelview28_arb = 0x0000873c
let gl_modelview29_arb = 0x0000873d
let gl_modelview30_arb = 0x0000873e
let gl_modelview31_arb = 0x0000873f
let gl_bump_rot_matrix_ati = 0x00008775
let gl_bump_rot_matrix_size_ati = 0x00008776
let gl_bump_num_tex_units_ati = 0x00008777
let gl_bump_tex_units_ati = 0x00008778
let gl_dudv_ati = 0x00008779
let gl_du8dv8_ati = 0x0000877a
let gl_bump_envmap_ati = 0x0000877b
let gl_bump_target_ati = 0x0000877c
let gl_pn_triangles_ati = 0x000087f0
let gl_max_pn_triangles_tesselation_level_ati = 0x000087f1
let gl_pn_triangles_point_mode_ati = 0x000087f2
let gl_pn_triangles_normal_mode_ati = 0x000087f3
let gl_pn_triangles_tesselation_level_ati = 0x000087f4
let gl_pn_triangles_point_mode_linear_ati = 0x000087f5
let gl_pn_triangles_point_mode_cubic_ati = 0x000087f6
let gl_pn_triangles_normal_mode_linear_ati = 0x000087f7
let gl_pn_triangles_normal_mode_quadratic_ati = 0x000087f8
let gl_stencil_back_func_ati = 0x00008800
let gl_stencil_back_fail_ati = 0x00008801
let gl_stencil_back_pass_depth_fail_ati = 0x00008802
let gl_stencil_back_pass_depth_pass_ati = 0x00008803
let gl_compressed_rgb_3dc_ati = 0x00008837
let gl_max_vertex_streams_ati = 0x0000876b
let gl_vertex_source_ati = 0x0000876c
let gl_vertex_stream0_ati = 0x0000876d
let gl_vertex_stream1_ati = 0x0000876e
let gl_vertex_stream2_ati = 0x0000876f
let gl_vertex_stream3_ati = 0x00008770
let gl_vertex_stream4_ati = 0x00008771
let gl_vertex_stream5_ati = 0x00008772
let gl_vertex_stream6_ati = 0x00008773
let gl_vertex_stream7_ati = 0x00008774
let gl_texture_point_mode_atix = 0x000060b0
let gl_texture_point_one_coord_atix = 0x000060b1
let gl_texture_point_sprite_atix = 0x000060b2
let gl_point_sprite_cull_mode_atix = 0x000060b3
let gl_point_sprite_cull_center_atix = 0x000060b4
let gl_point_sprite_cull_clip_atix = 0x000060b5
let gl_modulate_add_atix = 0x00008744
let gl_modulate_signed_add_atix = 0x00008745
let gl_modulate_subtract_atix = 0x00008746
let gl_secondary_color_atix = 0x00008747
let gl_texture_output_rgb_atix = 0x00008748
let gl_texture_output_alpha_atix = 0x00008749
let gl_output_point_size_atix = 0x0000610e
let gl_cg_vertex_shader_ext = 0x0000890e
let gl_cg_fragment_shader_ext = 0x0000890f
let gl_depth_bounds_test_ext = 0x00008890
let gl_depth_bounds_ext = 0x00008891
let gl_fog_coordinate_source_ext = 0x00008450
let gl_fog_coordinate_ext = 0x00008451
let gl_fragment_depth_ext = 0x00008452
let gl_current_fog_coordinate_ext = 0x00008453
let gl_fog_coordinate_array_type_ext = 0x00008454
let gl_fog_coordinate_array_stride_ext = 0x00008455
let gl_fog_coordinate_array_pointer_ext = 0x00008456
let gl_fog_coordinate_array_ext = 0x00008457
let gl_pixel_pack_buffer_ext = 0x000088eb
let gl_pixel_unpack_buffer_ext = 0x000088ec
let gl_pixel_pack_buffer_binding_ext = 0x000088ed
let gl_pixel_unpack_buffer_binding_ext = 0x000088ef
let gl_color_sum_ext = 0x00008458
let gl_current_secondary_color_ext = 0x00008459
let gl_secondary_color_array_size_ext = 0x0000845a
let gl_secondary_color_array_type_ext = 0x0000845b
let gl_secondary_color_array_stride_ext = 0x0000845c
let gl_secondary_color_array_pointer_ext = 0x0000845d
let gl_secondary_color_array_ext = 0x0000845e
let gl_normal_map_ext = 0x00008511
let gl_reflection_map_ext = 0x00008512
let gl_texture_cube_map_ext = 0x00008513
let gl_texture_binding_cube_map_ext = 0x00008514
let gl_texture_cube_map_positive_x_ext = 0x00008515
let gl_texture_cube_map_negative_x_ext = 0x00008516
let gl_texture_cube_map_positive_y_ext = 0x00008517
let gl_texture_cube_map_negative_y_ext = 0x00008518
let gl_texture_cube_map_positive_z_ext = 0x00008519
let gl_texture_cube_map_negative_z_ext = 0x0000851a
let gl_proxy_texture_cube_map_ext = 0x0000851b
let gl_max_cube_map_texture_size_ext = 0x0000851c
let gl_clamp_to_edge_ext = 0x0000812f
let gl_texture_rectangle_ext = 0x000084f5
let gl_texture_binding_rectangle_ext = 0x000084f6
let gl_proxy_texture_rectangle_ext = 0x000084f7
let gl_max_rectangle_texture_size_ext = 0x000084f8
let gl_vertex_shader_ext = 0x00008780
let gl_vertex_shader_binding_ext = 0x00008781
let gl_op_index_ext = 0x00008782
let gl_op_negate_ext = 0x00008783
let gl_op_dot3_ext = 0x00008784
let gl_op_dot4_ext = 0x00008785
let gl_op_mul_ext = 0x00008786
let gl_op_add_ext = 0x00008787
let gl_op_madd_ext = 0x00008788
let gl_op_frac_ext = 0x00008789
let gl_op_max_ext = 0x0000878a
let gl_op_min_ext = 0x0000878b
let gl_op_set_ge_ext = 0x0000878c
let gl_op_set_lt_ext = 0x0000878d
let gl_op_clamp_ext = 0x0000878e
let gl_op_floor_ext = 0x0000878f
let gl_op_round_ext = 0x00008790
let gl_op_exp_base_2_ext = 0x00008791
let gl_op_log_base_2_ext = 0x00008792
let gl_op_power_ext = 0x00008793
let gl_op_recip_ext = 0x00008794
let gl_op_recip_sqrt_ext = 0x00008795
let gl_op_sub_ext = 0x00008796
let gl_op_cross_product_ext = 0x00008797
let gl_op_multiply_matrix_ext = 0x00008798
let gl_op_mov_ext = 0x00008799
let gl_output_vertex_ext = 0x0000879a
let gl_output_color0_ext = 0x0000879b
let gl_output_color1_ext = 0x0000879c
let gl_output_texture_coord0_ext = 0x0000879d
let gl_output_texture_coord1_ext = 0x0000879e
let gl_output_texture_coord2_ext = 0x0000879f
let gl_output_texture_coord3_ext = 0x000087a0
let gl_output_texture_coord4_ext = 0x000087a1
let gl_output_texture_coord5_ext = 0x000087a2
let gl_output_texture_coord6_ext = 0x000087a3
let gl_output_texture_coord7_ext = 0x000087a4
let gl_output_texture_coord8_ext = 0x000087a5
let gl_output_texture_coord9_ext = 0x000087a6
let gl_output_texture_coord10_ext = 0x000087a7
let gl_output_texture_coord11_ext = 0x000087a8
let gl_output_texture_coord12_ext = 0x000087a9
let gl_output_texture_coord13_ext = 0x000087aa
let gl_output_texture_coord14_ext = 0x000087ab
let gl_output_texture_coord15_ext = 0x000087ac
let gl_output_texture_coord16_ext = 0x000087ad
let gl_output_texture_coord17_ext = 0x000087ae
let gl_output_texture_coord18_ext = 0x000087af
let gl_output_texture_coord19_ext = 0x000087b0
let gl_output_texture_coord20_ext = 0x000087b1
let gl_output_texture_coord21_ext = 0x000087b2
let gl_output_texture_coord22_ext = 0x000087b3
let gl_output_texture_coord23_ext = 0x000087b4
let gl_output_texture_coord24_ext = 0x000087b5
let gl_output_texture_coord25_ext = 0x000087b6
let gl_output_texture_coord26_ext = 0x000087b7
let gl_output_texture_coord27_ext = 0x000087b8
let gl_output_texture_coord28_ext = 0x000087b9
let gl_output_texture_coord29_ext = 0x000087ba
let gl_output_texture_coord30_ext = 0x000087bb
let gl_output_texture_coord31_ext = 0x000087bc
let gl_output_fog_ext = 0x000087bd
let gl_scalar_ext = 0x000087be
let gl_vector_ext = 0x000087bf
let gl_matrix_ext = 0x000087c0
let gl_variant_ext = 0x000087c1
let gl_invariant_ext = 0x000087c2
let gl_local_constant_ext = 0x000087c3
let gl_local_ext = 0x000087c4
let gl_max_vertex_shader_instructions_ext = 0x000087c5
let gl_max_vertex_shader_variants_ext = 0x000087c6
let gl_max_vertex_shader_invariants_ext = 0x000087c7
let gl_max_vertex_shader_local_constants_ext = 0x000087c8
let gl_max_vertex_shader_locals_ext = 0x000087c9
let gl_max_optimized_vertex_shader_instructions_ext = 0x000087ca
let gl_max_optimized_vertex_shader_variants_ext = 0x000087cb
let gl_max_optimized_vertex_shader_invariants_ext = 0x000087cc
let gl_max_optimized_vertex_shader_local_constants_ext = 0x000087cd
let gl_max_optimized_vertex_shader_locals_ext = 0x000087ce
let gl_vertex_shader_instructions_ext = 0x000087cf
let gl_vertex_shader_variants_ext = 0x000087d0
let gl_vertex_shader_invariants_ext = 0x000087d1
let gl_vertex_shader_local_constants_ext = 0x000087d2
let gl_vertex_shader_locals_ext = 0x000087d3
let gl_vertex_shader_optimized_ext = 0x000087d4
let gl_x_ext = 0x000087d5
let gl_y_ext = 0x000087d6
let gl_z_ext = 0x000087d7
let gl_w_ext = 0x000087d8
let gl_negative_x_ext = 0x000087d9
let gl_negative_y_ext = 0x000087da
let gl_negative_z_ext = 0x000087db
let gl_negative_w_ext = 0x000087dc
let gl_zero_ext = 0x000087dd
let gl_one_ext = 0x000087de
let gl_negative_one_ext = 0x000087df
let gl_normalized_range_ext = 0x000087e0
let gl_full_range_ext = 0x000087e1
let gl_current_vertex_ext = 0x000087e2
let gl_mvp_matrix_ext = 0x000087e3
let gl_variant_value_ext = 0x000087e4
let gl_variant_datatype_ext = 0x000087e5
let gl_variant_array_stride_ext = 0x000087e6
let gl_variant_array_type_ext = 0x000087e7
let gl_variant_array_ext = 0x000087e8
let gl_variant_array_pointer_ext = 0x000087e9
let gl_invariant_value_ext = 0x000087ea
let gl_invariant_datatype_ext = 0x000087eb
let gl_local_constant_value_ext = 0x000087ec
let gl_local_constant_datatype_ext = 0x000087ed
let gl_ktx_front_region = 0x00000000
let gl_ktx_back_region = 0x00000001
let gl_ktx_z_region = 0x00000002
let gl_ktx_stencil_region = 0x00000003
let gl_max_program_exec_instructions_nv = 0x000088f4
let gl_max_program_call_depth_nv = 0x000088f5
let gl_max_program_if_depth_nv = 0x000088f6
let gl_max_program_loop_depth_nv = 0x000088f7
let gl_max_program_loop_count_nv = 0x000088f8
let gl_max_vertex_texture_image_units_arb = 0x00008b4c
let gl_multisample_3dfx = 0x000086b2
let gl_sample_buffers_3dfx = 0x000086b3
let gl_samples_3dfx = 0x000086b4
let gl_multisample_bit_3dfx = 0x20000000
let gl_compressed_rgb_fxt1_3dfx = 0x000086b0
let gl_compressed_rgba_fxt1_3dfx = 0x000086b1
let gl_unpack_client_storage_apple = 0x000085b2
let gl_element_array_apple = 0x00008768
let gl_element_array_type_apple = 0x00008769
let gl_element_array_pointer_apple = 0x0000876a
let gl_draw_pixels_apple = 0x00008a0a
let gl_fence_apple = 0x00008a0b
let gl_half_apple = 0x0000140b
let gl_color_float_apple = 0x00008a0f
let gl_rgba_float32_apple = 0x00008814
let gl_rgb_float32_apple = 0x00008815
let gl_alpha_float32_apple = 0x00008816
let gl_intensity_float32_apple = 0x00008817
let gl_luminance_float32_apple = 0x00008818
let gl_luminance_alpha_float32_apple = 0x00008819
let gl_rgba_float16_apple = 0x0000881a
let gl_rgb_float16_apple = 0x0000881b
let gl_alpha_float16_apple = 0x0000881c
let gl_intensity_float16_apple = 0x0000881d
let gl_luminance_float16_apple = 0x0000881e
let gl_luminance_alpha_float16_apple = 0x0000881f
let gl_min_pbuffer_viewport_dims_apple = 0x00008a10
let gl_light_model_specular_vector_apple = 0x000085b0
let gl_texture_storage_hint_apple = 0x000085bc
let gl_storage_private_apple = 0x000085bd
let gl_storage_cached_apple = 0x000085be
let gl_storage_shared_apple = 0x000085bf
let gl_texture_range_length_apple = 0x000085b7
let gl_texture_range_pointer_apple = 0x000085b8
let gl_transform_hint_apple = 0x000085b1
let gl_vertex_array_binding_apple = 0x000085b5
let gl_vertex_array_range_apple = 0x0000851d
let gl_vertex_array_range_length_apple = 0x0000851e
let gl_vertex_array_storage_hint_apple = 0x0000851f
let gl_max_vertex_array_range_element_apple = 0x00008520
let gl_vertex_array_range_pointer_apple = 0x00008521
let gl_ycbcr_422_apple = 0x000085b9
let gl_unsigned_short_8_8_apple = 0x000085ba
let gl_unsigned_short_8_8_rev_apple = 0x000085bb
let gl_rgba_float_mode_arb = 0x00008820
let gl_clamp_vertex_color_arb = 0x0000891a
let gl_clamp_fragment_color_arb = 0x0000891b
let gl_clamp_read_color_arb = 0x0000891c
let gl_fixed_only_arb = 0x0000891d
let gl_depth_component16_arb = 0x000081a5
let gl_depth_component24_arb = 0x000081a6
let gl_depth_component32_arb = 0x000081a7
let gl_texture_depth_size_arb = 0x0000884a
let gl_depth_texture_mode_arb = 0x0000884b
let gl_max_draw_buffers_arb = 0x00008824
let gl_draw_buffer0_arb = 0x00008825
let gl_draw_buffer1_arb = 0x00008826
let gl_draw_buffer2_arb = 0x00008827
let gl_draw_buffer3_arb = 0x00008828
let gl_draw_buffer4_arb = 0x00008829
let gl_draw_buffer5_arb = 0x0000882a
let gl_draw_buffer6_arb = 0x0000882b
let gl_draw_buffer7_arb = 0x0000882c
let gl_draw_buffer8_arb = 0x0000882d
let gl_draw_buffer9_arb = 0x0000882e
let gl_draw_buffer10_arb = 0x0000882f
let gl_draw_buffer11_arb = 0x00008830
let gl_draw_buffer12_arb = 0x00008831
let gl_draw_buffer13_arb = 0x00008832
let gl_draw_buffer14_arb = 0x00008833
let gl_draw_buffer15_arb = 0x00008834
let gl_fragment_program_arb = 0x00008804
let gl_program_alu_instructions_arb = 0x00008805
let gl_program_tex_instructions_arb = 0x00008806
let gl_program_tex_indirections_arb = 0x00008807
let gl_program_native_alu_instructions_arb = 0x00008808
let gl_program_native_tex_instructions_arb = 0x00008809
let gl_program_native_tex_indirections_arb = 0x0000880a
let gl_max_program_alu_instructions_arb = 0x0000880b
let gl_max_program_tex_instructions_arb = 0x0000880c
let gl_max_program_tex_indirections_arb = 0x0000880d
let gl_max_program_native_alu_instructions_arb = 0x0000880e
let gl_max_program_native_tex_instructions_arb = 0x0000880f
let gl_max_program_native_tex_indirections_arb = 0x00008810
let gl_max_texture_coords_arb = 0x00008871
let gl_max_texture_image_units_arb = 0x00008872
let gl_fragment_shader_arb = 0x00008b30
let gl_max_fragment_uniform_components_arb = 0x00008b49
let gl_fragment_shader_derivative_hint_arb = 0x00008b8b
let gl_half_float_arb = 0x0000140b
let gl_multisample_arb = 0x0000809d
let gl_sample_alpha_to_coverage_arb = 0x0000809e
let gl_sample_alpha_to_one_arb = 0x0000809f
let gl_sample_coverage_arb = 0x000080a0
let gl_sample_buffers_arb = 0x000080a8
let gl_samples_arb = 0x000080a9
let gl_sample_coverage_value_arb = 0x000080aa
let gl_sample_coverage_invert_arb = 0x000080ab
let gl_multisample_bit_arb = 0x20000000
let gl_query_counter_bits_arb = 0x00008864
let gl_current_query_arb = 0x00008865
let gl_query_result_arb = 0x00008866
let gl_query_result_available_arb = 0x00008867
let gl_samples_passed_arb = 0x00008914
let gl_pixel_pack_buffer_arb = 0x000088eb
let gl_pixel_unpack_buffer_arb = 0x000088ec
let gl_pixel_pack_buffer_binding_arb = 0x000088ed
let gl_pixel_unpack_buffer_binding_arb = 0x000088ef
let gl_point_size_min_arb = 0x00008126
let gl_point_size_max_arb = 0x00008127
let gl_point_fade_threshold_size_arb = 0x00008128
let gl_point_distance_attenuation_arb = 0x00008129
let gl_point_sprite_arb = 0x00008861
let gl_coord_replace_arb = 0x00008862
let gl_program_object_arb = 0x00008b40
let gl_shader_object_arb = 0x00008b48
let gl_object_type_arb = 0x00008b4e
let gl_object_subtype_arb = 0x00008b4f
let gl_float_vec2_arb = 0x00008b50
let gl_float_vec3_arb = 0x00008b51
let gl_float_vec4_arb = 0x00008b52
let gl_int_vec2_arb = 0x00008b53
let gl_int_vec3_arb = 0x00008b54
let gl_int_vec4_arb = 0x00008b55
let gl_bool_arb = 0x00008b56
let gl_bool_vec2_arb = 0x00008b57
let gl_bool_vec3_arb = 0x00008b58
let gl_bool_vec4_arb = 0x00008b59
let gl_float_mat2_arb = 0x00008b5a
let gl_float_mat3_arb = 0x00008b5b
let gl_float_mat4_arb = 0x00008b5c
let gl_sampler_1d_arb = 0x00008b5d
let gl_sampler_2d_arb = 0x00008b5e
let gl_sampler_3d_arb = 0x00008b5f
let gl_sampler_cube_arb = 0x00008b60
let gl_sampler_1d_shadow_arb = 0x00008b61
let gl_sampler_2d_shadow_arb = 0x00008b62
let gl_sampler_2d_rect_arb = 0x00008b63
let gl_sampler_2d_rect_shadow_arb = 0x00008b64
let gl_object_delete_status_arb = 0x00008b80
let gl_object_compile_status_arb = 0x00008b81
let gl_object_link_status_arb = 0x00008b82
let gl_object_validate_status_arb = 0x00008b83
let gl_object_info_log_length_arb = 0x00008b84
let gl_object_attached_objects_arb = 0x00008b85
let gl_object_active_uniforms_arb = 0x00008b86
let gl_object_active_uniform_max_length_arb = 0x00008b87
let gl_object_shader_source_length_arb = 0x00008b88
let gl_shading_language_version_arb = 0x00008b8c
let gl_texture_compare_mode_arb = 0x0000884c
let gl_texture_compare_func_arb = 0x0000884d
let gl_compare_r_to_texture_arb = 0x0000884e
let gl_texture_compare_fail_value_arb = 0x000080bf
let gl_clamp_to_border_arb = 0x0000812d
let gl_compressed_alpha_arb = 0x000084e9
let gl_compressed_luminance_arb = 0x000084ea
let gl_compressed_luminance_alpha_arb = 0x000084eb
let gl_compressed_intensity_arb = 0x000084ec
let gl_compressed_rgb_arb = 0x000084ed
let gl_compressed_rgba_arb = 0x000084ee
let gl_texture_compression_hint_arb = 0x000084ef
let gl_texture_compressed_image_size_arb = 0x000086a0
let gl_texture_compressed_arb = 0x000086a1
let gl_num_compressed_texture_formats_arb = 0x000086a2
let gl_compressed_texture_formats_arb = 0x000086a3
let gl_normal_map_arb = 0x00008511
let gl_reflection_map_arb = 0x00008512
let gl_texture_cube_map_arb = 0x00008513
let gl_texture_binding_cube_map_arb = 0x00008514
let gl_texture_cube_map_positive_x_arb = 0x00008515
let gl_texture_cube_map_negative_x_arb = 0x00008516
let gl_texture_cube_map_positive_y_arb = 0x00008517
let gl_texture_cube_map_negative_y_arb = 0x00008518
let gl_texture_cube_map_positive_z_arb = 0x00008519
let gl_texture_cube_map_negative_z_arb = 0x0000851a
let gl_proxy_texture_cube_map_arb = 0x0000851b
let gl_max_cube_map_texture_size_arb = 0x0000851c
let gl_subtract_arb = 0x000084e7
let gl_combine_arb = 0x00008570
let gl_combine_rgb_arb = 0x00008571
let gl_combine_alpha_arb = 0x00008572
let gl_rgb_scale_arb = 0x00008573
let gl_add_signed_arb = 0x00008574
let gl_interpolate_arb = 0x00008575
let gl_constant_arb = 0x00008576
let gl_primary_color_arb = 0x00008577
let gl_previous_arb = 0x00008578
let gl_source0_rgb_arb = 0x00008580
let gl_source1_rgb_arb = 0x00008581
let gl_source2_rgb_arb = 0x00008582
let gl_source0_alpha_arb = 0x00008588
let gl_source1_alpha_arb = 0x00008589
let gl_source2_alpha_arb = 0x0000858a
let gl_operand0_rgb_arb = 0x00008590
let gl_operand1_rgb_arb = 0x00008591
let gl_operand2_rgb_arb = 0x00008592
let gl_operand0_alpha_arb = 0x00008598
let gl_operand1_alpha_arb = 0x00008599
let gl_operand2_alpha_arb = 0x0000859a
let gl_dot3_rgb_arb = 0x000086ae
let gl_dot3_rgba_arb = 0x000086af
let gl_rgba32f_arb = 0x00008814
let gl_rgb32f_arb = 0x00008815
let gl_alpha32f_arb = 0x00008816
let gl_intensity32f_arb = 0x00008817
let gl_luminance32f_arb = 0x00008818
let gl_luminance_alpha32f_arb = 0x00008819
let gl_rgba16f_arb = 0x0000881a
let gl_rgb16f_arb = 0x0000881b
let gl_alpha16f_arb = 0x0000881c
let gl_intensity16f_arb = 0x0000881d
let gl_luminance16f_arb = 0x0000881e
let gl_luminance_alpha16f_arb = 0x0000881f
let gl_texture_red_type_arb = 0x00008c10
let gl_texture_green_type_arb = 0x00008c11
let gl_texture_blue_type_arb = 0x00008c12
let gl_texture_alpha_type_arb = 0x00008c13
let gl_texture_luminance_type_arb = 0x00008c14
let gl_texture_intensity_type_arb = 0x00008c15
let gl_texture_depth_type_arb = 0x00008c16
let gl_unsigned_normalized_arb = 0x00008c17
let gl_mirrored_repeat_arb = 0x00008370
let gl_texture_rectangle_arb = 0x000084f5
let gl_texture_binding_rectangle_arb = 0x000084f6
let gl_proxy_texture_rectangle_arb = 0x000084f7
let gl_max_rectangle_texture_size_arb = 0x000084f8
let gl_transpose_modelview_matrix_arb = 0x000084e3
let gl_transpose_projection_matrix_arb = 0x000084e4
let gl_transpose_texture_matrix_arb = 0x000084e5
let gl_transpose_color_matrix_arb = 0x000084e6
let gl_buffer_size_arb = 0x00008764
let gl_buffer_usage_arb = 0x00008765
let gl_array_buffer_arb = 0x00008892
let gl_element_array_buffer_arb = 0x00008893
let gl_array_buffer_binding_arb = 0x00008894
let gl_element_array_buffer_binding_arb = 0x00008895
let gl_vertex_array_buffer_binding_arb = 0x00008896
let gl_normal_array_buffer_binding_arb = 0x00008897
let gl_color_array_buffer_binding_arb = 0x00008898
let gl_index_array_buffer_binding_arb = 0x00008899
let gl_texture_coord_array_buffer_binding_arb = 0x0000889a
let gl_edge_flag_array_buffer_binding_arb = 0x0000889b
let gl_secondary_color_array_buffer_binding_arb = 0x0000889c
let gl_fog_coordinate_array_buffer_binding_arb = 0x0000889d
let gl_weight_array_buffer_binding_arb = 0x0000889e
let gl_vertex_attrib_array_buffer_binding_arb = 0x0000889f
let gl_read_only_arb = 0x000088b8
let gl_write_only_arb = 0x000088b9
let gl_read_write_arb = 0x000088ba
let gl_buffer_access_arb = 0x000088bb
let gl_buffer_mapped_arb = 0x000088bc
let gl_buffer_map_pointer_arb = 0x000088bd
let gl_stream_draw_arb = 0x000088e0
let gl_stream_read_arb = 0x000088e1
let gl_stream_copy_arb = 0x000088e2
let gl_static_draw_arb = 0x000088e4
let gl_static_read_arb = 0x000088e5
let gl_static_copy_arb = 0x000088e6
let gl_dynamic_draw_arb = 0x000088e8
let gl_dynamic_read_arb = 0x000088e9
let gl_dynamic_copy_arb = 0x000088ea
let gl_color_sum_arb = 0x00008458
let gl_vertex_program_arb = 0x00008620
let gl_vertex_attrib_array_enabled_arb = 0x00008622
let gl_vertex_attrib_array_size_arb = 0x00008623
let gl_vertex_attrib_array_stride_arb = 0x00008624
let gl_vertex_attrib_array_type_arb = 0x00008625
let gl_current_vertex_attrib_arb = 0x00008626
let gl_program_length_arb = 0x00008627
let gl_program_string_arb = 0x00008628
let gl_max_program_matrix_stack_depth_arb = 0x0000862e
let gl_max_program_matrices_arb = 0x0000862f
let gl_current_matrix_stack_depth_arb = 0x00008640
let gl_current_matrix_arb = 0x00008641
let gl_vertex_program_point_size_arb = 0x00008642
let gl_vertex_program_two_side_arb = 0x00008643
let gl_vertex_attrib_array_pointer_arb = 0x00008645
let gl_program_error_position_arb = 0x0000864b
let gl_program_binding_arb = 0x00008677
let gl_max_vertex_attribs_arb = 0x00008869
let gl_vertex_attrib_array_normalized_arb = 0x0000886a
let gl_program_error_string_arb = 0x00008874
let gl_program_format_ascii_arb = 0x00008875
let gl_program_format_arb = 0x00008876
let gl_program_instructions_arb = 0x000088a0
let gl_max_program_instructions_arb = 0x000088a1
let gl_program_native_instructions_arb = 0x000088a2
let gl_max_program_native_instructions_arb = 0x000088a3
let gl_program_temporaries_arb = 0x000088a4
let gl_max_program_temporaries_arb = 0x000088a5
let gl_program_native_temporaries_arb = 0x000088a6
let gl_max_program_native_temporaries_arb = 0x000088a7
let gl_program_parameters_arb = 0x000088a8
let gl_max_program_parameters_arb = 0x000088a9
let gl_program_native_parameters_arb = 0x000088aa
let gl_max_program_native_parameters_arb = 0x000088ab
let gl_program_attribs_arb = 0x000088ac
let gl_max_program_attribs_arb = 0x000088ad
let gl_program_native_attribs_arb = 0x000088ae
let gl_max_program_native_attribs_arb = 0x000088af
let gl_program_address_registers_arb = 0x000088b0
let gl_max_program_address_registers_arb = 0x000088b1
let gl_program_native_address_registers_arb = 0x000088b2
let gl_max_program_native_address_registers_arb = 0x000088b3
let gl_max_program_local_parameters_arb = 0x000088b4
let gl_max_program_env_parameters_arb = 0x000088b5
let gl_program_under_native_limits_arb = 0x000088b6
let gl_transpose_current_matrix_arb = 0x000088b7
let gl_matrix0_arb = 0x000088c0
let gl_matrix1_arb = 0x000088c1
let gl_matrix2_arb = 0x000088c2
let gl_matrix3_arb = 0x000088c3
let gl_matrix4_arb = 0x000088c4
let gl_matrix5_arb = 0x000088c5
let gl_matrix6_arb = 0x000088c6
let gl_matrix7_arb = 0x000088c7
let gl_matrix8_arb = 0x000088c8
let gl_matrix9_arb = 0x000088c9
let gl_matrix10_arb = 0x000088ca
let gl_matrix11_arb = 0x000088cb
let gl_matrix12_arb = 0x000088cc
let gl_matrix13_arb = 0x000088cd
let gl_matrix14_arb = 0x000088ce
let gl_matrix15_arb = 0x000088cf
let gl_matrix16_arb = 0x000088d0
let gl_matrix17_arb = 0x000088d1
let gl_matrix18_arb = 0x000088d2
let gl_matrix19_arb = 0x000088d3
let gl_matrix20_arb = 0x000088d4
let gl_matrix21_arb = 0x000088d5
let gl_matrix22_arb = 0x000088d6
let gl_matrix23_arb = 0x000088d7
let gl_matrix24_arb = 0x000088d8
let gl_matrix25_arb = 0x000088d9
let gl_matrix26_arb = 0x000088da
let gl_matrix27_arb = 0x000088db
let gl_matrix28_arb = 0x000088dc
let gl_matrix29_arb = 0x000088dd
let gl_matrix30_arb = 0x000088de
let gl_matrix31_arb = 0x000088df
let gl_vertex_shader_arb = 0x00008b31
let gl_max_vertex_uniform_components_arb = 0x00008b4a
let gl_max_varying_floats_arb = 0x00008b4b
let gl_max_vertex_texture_image_units_arb = 0x00008b4c
let gl_max_combined_texture_image_units_arb = 0x00008b4d
let gl_object_active_attributes_arb = 0x00008b89
let gl_object_active_attribute_max_length_arb = 0x00008b8a
let gl_max_draw_buffers_ati = 0x00008824
let gl_draw_buffer0_ati = 0x00008825
let gl_draw_buffer1_ati = 0x00008826
let gl_draw_buffer2_ati = 0x00008827
let gl_draw_buffer3_ati = 0x00008828
let gl_draw_buffer4_ati = 0x00008829
let gl_draw_buffer5_ati = 0x0000882a
let gl_draw_buffer6_ati = 0x0000882b
let gl_draw_buffer7_ati = 0x0000882c
let gl_draw_buffer8_ati = 0x0000882d
let gl_draw_buffer9_ati = 0x0000882e
let gl_draw_buffer10_ati = 0x0000882f
let gl_draw_buffer11_ati = 0x00008830
let gl_draw_buffer12_ati = 0x00008831
let gl_draw_buffer13_ati = 0x00008832
let gl_draw_buffer14_ati = 0x00008833
let gl_draw_buffer15_ati = 0x00008834
let gl_element_array_ati = 0x00008768
let gl_element_array_type_ati = 0x00008769
let gl_element_array_pointer_ati = 0x0000876a
let gl_red_bit_ati = 0x00000001
let gl_2x_bit_ati = 0x00000001
let gl_4x_bit_ati = 0x00000002
let gl_green_bit_ati = 0x00000002
let gl_comp_bit_ati = 0x00000002
let gl_blue_bit_ati = 0x00000004
let gl_8x_bit_ati = 0x00000004
let gl_negate_bit_ati = 0x00000004
let gl_bias_bit_ati = 0x00000008
let gl_half_bit_ati = 0x00000008
let gl_quarter_bit_ati = 0x00000010
let gl_eighth_bit_ati = 0x00000020
let gl_saturate_bit_ati = 0x00000040
let gl_fragment_shader_ati = 0x00008920
let gl_reg_0_ati = 0x00008921
let gl_reg_1_ati = 0x00008922
let gl_reg_2_ati = 0x00008923
let gl_reg_3_ati = 0x00008924
let gl_reg_4_ati = 0x00008925
let gl_reg_5_ati = 0x00008926
let gl_con_0_ati = 0x00008941
let gl_con_1_ati = 0x00008942
let gl_con_2_ati = 0x00008943
let gl_con_3_ati = 0x00008944
let gl_con_4_ati = 0x00008945
let gl_con_5_ati = 0x00008946
let gl_con_6_ati = 0x00008947
let gl_con_7_ati = 0x00008948
let gl_mov_ati = 0x00008961
let gl_add_ati = 0x00008963
let gl_mul_ati = 0x00008964
let gl_sub_ati = 0x00008965
let gl_dot3_ati = 0x00008966
let gl_dot4_ati = 0x00008967
let gl_mad_ati = 0x00008968
let gl_lerp_ati = 0x00008969
let gl_cnd_ati = 0x0000896a
let gl_cnd0_ati = 0x0000896b
let gl_dot2_add_ati = 0x0000896c
let gl_secondary_interpolator_ati = 0x0000896d
let gl_swizzle_str_ati = 0x00008976
let gl_swizzle_stq_ati = 0x00008977
let gl_swizzle_str_dr_ati = 0x00008978
let gl_swizzle_stq_dq_ati = 0x00008979
let gl_num_fragment_registers_ati = 0x0000896e
let gl_num_fragment_constants_ati = 0x0000896f
let gl_num_passes_ati = 0x00008970
let gl_num_instructions_per_pass_ati = 0x00008971
let gl_num_instructions_total_ati = 0x00008972
let gl_num_input_interpolator_components_ati = 0x00008973
let gl_num_loopback_components_ati = 0x00008974
let gl_color_alpha_pairing_ati = 0x00008975
let gl_swizzle_strq_ati = 0x0000897a
let gl_swizzle_strq_dq_ati = 0x0000897b
let gl_text_fragment_shader_ati = 0x00008200
let gl_compressed_luminance_alpha_3dc_ati = 0x00008837
let gl_modulate_add_ati = 0x00008744
let gl_modulate_signed_add_ati = 0x00008745
let gl_modulate_subtract_ati = 0x00008746
let gl_rgba_float32_ati = 0x00008814
let gl_rgb_float32_ati = 0x00008815
let gl_alpha_float32_ati = 0x00008816
let gl_intensity_float32_ati = 0x00008817
let gl_luminance_float32_ati = 0x00008818
let gl_luminance_alpha_float32_ati = 0x00008819
let gl_rgba_float16_ati = 0x0000881a
let gl_rgb_float16_ati = 0x0000881b
let gl_alpha_float16_ati = 0x0000881c
let gl_intensity_float16_ati = 0x0000881d
let gl_luminance_float16_ati = 0x0000881e
let gl_luminance_alpha_float16_ati = 0x0000881f
let gl_mirror_clamp_ati = 0x00008742
let gl_mirror_clamp_to_edge_ati = 0x00008743
let gl_static_ati = 0x00008760
let gl_dynamic_ati = 0x00008761
let gl_preserve_ati = 0x00008762
let gl_discard_ati = 0x00008763
let gl_object_buffer_size_ati = 0x00008764
let gl_object_buffer_usage_ati = 0x00008765
let gl_array_object_buffer_ati = 0x00008766
let gl_array_object_offset_ati = 0x00008767
let gl_422_ext = 0x000080cc
let gl_422_rev_ext = 0x000080cd
let gl_422_average_ext = 0x000080ce
let gl_422_rev_average_ext = 0x000080cf
let gl_abgr_ext = 0x00008000
let gl_bgr_ext = 0x000080e0
let gl_bgra_ext = 0x000080e1
let gl_max_vertex_bindable_uniforms_ext = 0x00008de2
let gl_max_fragment_bindable_uniforms_ext = 0x00008de3
let gl_max_geometry_bindable_uniforms_ext = 0x00008de4
let gl_max_bindable_uniform_size_ext = 0x00008ded
let gl_uniform_buffer_binding_ext = 0x00008def
let gl_uniform_buffer_ext = 0x00008dee
let gl_constant_color_ext = 0x00008001
let gl_one_minus_constant_color_ext = 0x00008002
let gl_constant_alpha_ext = 0x00008003
let gl_one_minus_constant_alpha_ext = 0x00008004
let gl_blend_color_ext = 0x00008005
let gl_blend_equation_rgb_ext = 0x00008009
let gl_blend_equation_alpha_ext = 0x0000883d
let gl_blend_dst_rgb_ext = 0x000080c8
let gl_blend_src_rgb_ext = 0x000080c9
let gl_blend_dst_alpha_ext = 0x000080ca
let gl_blend_src_alpha_ext = 0x000080cb
let gl_func_add_ext = 0x00008006
let gl_min_ext = 0x00008007
let gl_max_ext = 0x00008008
let gl_blend_equation_ext = 0x00008009
let gl_func_subtract_ext = 0x0000800a
let gl_func_reverse_subtract_ext = 0x0000800b
let gl_clip_volume_clipping_hint_ext = 0x000080f0
let gl_cmyk_ext = 0x0000800c
let gl_cmyka_ext = 0x0000800d
let gl_pack_cmyk_hint_ext = 0x0000800e
let gl_unpack_cmyk_hint_ext = 0x0000800f
let gl_convolution_1d_ext = 0x00008010
let gl_convolution_2d_ext = 0x00008011
let gl_separable_2d_ext = 0x00008012
let gl_convolution_border_mode_ext = 0x00008013
let gl_convolution_filter_scale_ext = 0x00008014
let gl_convolution_filter_bias_ext = 0x00008015
let gl_reduce_ext = 0x00008016
let gl_convolution_format_ext = 0x00008017
let gl_convolution_width_ext = 0x00008018
let gl_convolution_height_ext = 0x00008019
let gl_max_convolution_width_ext = 0x0000801a
let gl_max_convolution_height_ext = 0x0000801b
let gl_post_convolution_red_scale_ext = 0x0000801c
let gl_post_convolution_green_scale_ext = 0x0000801d
let gl_post_convolution_blue_scale_ext = 0x0000801e
let gl_post_convolution_alpha_scale_ext = 0x0000801f
let gl_post_convolution_red_bias_ext = 0x00008020
let gl_post_convolution_green_bias_ext = 0x00008021
let gl_post_convolution_blue_bias_ext = 0x00008022
let gl_post_convolution_alpha_bias_ext = 0x00008023
let gl_tangent_array_ext = 0x00008439
let gl_binormal_array_ext = 0x0000843a
let gl_current_tangent_ext = 0x0000843b
let gl_current_binormal_ext = 0x0000843c
let gl_tangent_array_type_ext = 0x0000843e
let gl_tangent_array_stride_ext = 0x0000843f
let gl_binormal_array_type_ext = 0x00008440
let gl_binormal_array_stride_ext = 0x00008441
let gl_tangent_array_pointer_ext = 0x00008442
let gl_binormal_array_pointer_ext = 0x00008443
let gl_map1_tangent_ext = 0x00008444
let gl_map2_tangent_ext = 0x00008445
let gl_map1_binormal_ext = 0x00008446
let gl_map2_binormal_ext = 0x00008447
let gl_fragment_lighting_ext = 0x00008400
let gl_fragment_color_material_ext = 0x00008401
let gl_fragment_color_material_face_ext = 0x00008402
let gl_fragment_color_material_parameter_ext = 0x00008403
let gl_max_fragment_lights_ext = 0x00008404
let gl_max_active_lights_ext = 0x00008405
let gl_current_raster_normal_ext = 0x00008406
let gl_light_env_mode_ext = 0x00008407
let gl_fragment_light_model_local_viewer_ext = 0x00008408
let gl_fragment_light_model_two_side_ext = 0x00008409
let gl_fragment_light_model_ambient_ext = 0x0000840a
let gl_fragment_light_model_normal_interpolation_ext = 0x0000840b
let gl_fragment_light0_ext = 0x0000840c
let gl_fragment_light7_ext = 0x00008413
let gl_draw_framebuffer_binding_ext = 0x00008ca6
let gl_read_framebuffer_ext = 0x00008ca8
let gl_draw_framebuffer_ext = 0x00008ca9
let gl_read_framebuffer_binding_ext = 0x00008caa
let gl_renderbuffer_samples_ext = 0x00008cab
let gl_framebuffer_incomplete_multisample_ext = 0x00008d56
let gl_max_samples_ext = 0x00008d57
let gl_invalid_framebuffer_operation_ext = 0x00000506
let gl_max_renderbuffer_size_ext = 0x000084e8
let gl_framebuffer_binding_ext = 0x00008ca6
let gl_renderbuffer_binding_ext = 0x00008ca7
let gl_framebuffer_attachment_object_type_ext = 0x00008cd0
let gl_framebuffer_attachment_object_name_ext = 0x00008cd1
let gl_framebuffer_attachment_texture_level_ext = 0x00008cd2
let gl_framebuffer_attachment_texture_cube_map_face_ext = 0x00008cd3
let gl_framebuffer_attachment_texture_3d_zoffset_ext = 0x00008cd4
let gl_framebuffer_complete_ext = 0x00008cd5
let gl_framebuffer_incomplete_attachment_ext = 0x00008cd6
let gl_framebuffer_incomplete_missing_attachment_ext = 0x00008cd7
let gl_framebuffer_incomplete_dimensions_ext = 0x00008cd9
let gl_framebuffer_incomplete_formats_ext = 0x00008cda
let gl_framebuffer_incomplete_draw_buffer_ext = 0x00008cdb
let gl_framebuffer_incomplete_read_buffer_ext = 0x00008cdc
let gl_framebuffer_unsupported_ext = 0x00008cdd
let gl_max_color_attachments_ext = 0x00008cdf
let gl_color_attachment0_ext = 0x00008ce0
let gl_color_attachment1_ext = 0x00008ce1
let gl_color_attachment2_ext = 0x00008ce2
let gl_color_attachment3_ext = 0x00008ce3
let gl_color_attachment4_ext = 0x00008ce4
let gl_color_attachment5_ext = 0x00008ce5
let gl_color_attachment6_ext = 0x00008ce6
let gl_color_attachment7_ext = 0x00008ce7
let gl_color_attachment8_ext = 0x00008ce8
let gl_color_attachment9_ext = 0x00008ce9
let gl_color_attachment10_ext = 0x00008cea
let gl_color_attachment11_ext = 0x00008ceb
let gl_color_attachment12_ext = 0x00008cec
let gl_color_attachment13_ext = 0x00008ced
let gl_color_attachment14_ext = 0x00008cee
let gl_color_attachment15_ext = 0x00008cef
let gl_depth_attachment_ext = 0x00008d00
let gl_stencil_attachment_ext = 0x00008d20
let gl_framebuffer_ext = 0x00008d40
let gl_renderbuffer_ext = 0x00008d41
let gl_renderbuffer_width_ext = 0x00008d42
let gl_renderbuffer_height_ext = 0x00008d43
let gl_renderbuffer_internal_format_ext = 0x00008d44
let gl_stencil_index1_ext = 0x00008d46
let gl_stencil_index4_ext = 0x00008d47
let gl_stencil_index8_ext = 0x00008d48
let gl_stencil_index16_ext = 0x00008d49
let gl_renderbuffer_red_size_ext = 0x00008d50
let gl_renderbuffer_green_size_ext = 0x00008d51
let gl_renderbuffer_blue_size_ext = 0x00008d52
let gl_renderbuffer_alpha_size_ext = 0x00008d53
let gl_renderbuffer_depth_size_ext = 0x00008d54
let gl_renderbuffer_stencil_size_ext = 0x00008d55
let gl_framebuffer_srgb_ext = 0x00008db9
let gl_framebuffer_srgb_capable_ext = 0x00008dba
let gl_geometry_shader_ext = 0x00008dd9
let gl_max_geometry_varying_components_ext = 0x00008ddd
let gl_max_vertex_varying_components_ext = 0x00008dde
let gl_max_varying_components_ext = 0x00008b4b
let gl_max_geometry_uniform_components_ext = 0x00008ddf
let gl_max_geometry_output_vertices_ext = 0x00008de0
let gl_max_geometry_total_output_components_ext = 0x00008de1
let gl_geometry_vertices_out_ext = 0x00008dda
let gl_geometry_input_type_ext = 0x00008ddb
let gl_geometry_output_type_ext = 0x00008ddc
let gl_max_geometry_texture_image_units_ext = 0x00008c29
let gl_lines_adjacency_ext = 0x0000000a
let gl_line_strip_adjacency_ext = 0x0000000b
let gl_triangles_adjacency_ext = 0x0000000c
let gl_triangle_strip_adjacency_ext = 0x0000000d
let gl_framebuffer_attachment_layered_ext = 0x00008da7
let gl_framebuffer_incomplete_layer_targets_ext = 0x00008da8
let gl_framebuffer_incomplete_layer_count_ext = 0x00008da9
let gl_framebuffer_attachment_texture_layer_ext = 0x00008cd4
let gl_program_point_size_ext = 0x00008642
let gl_sampler_1d_array_ext = 0x00008dc0
let gl_sampler_2d_array_ext = 0x00008dc1
let gl_sampler_buffer_ext = 0x00008dc2
let gl_sampler_1d_array_shadow_ext = 0x00008dc3
let gl_sampler_2d_array_shadow_ext = 0x00008dc4
let gl_sampler_cube_shadow_ext = 0x00008dc5
let gl_unsigned_int_vec2_ext = 0x00008dc6
let gl_unsigned_int_vec3_ext = 0x00008dc7
let gl_unsigned_int_vec4_ext = 0x00008dc8
let gl_int_sampler_1d_ext = 0x00008dc9
let gl_int_sampler_2d_ext = 0x00008dca
let gl_int_sampler_3d_ext = 0x00008dcb
let gl_int_sampler_cube_ext = 0x00008dcc
let gl_int_sampler_2d_rect_ext = 0x00008dcd
let gl_int_sampler_1d_array_ext = 0x00008dce
let gl_int_sampler_2d_array_ext = 0x00008dcf
let gl_int_sampler_buffer_ext = 0x00008dd0
let gl_unsigned_int_sampler_1d_ext = 0x00008dd1
let gl_unsigned_int_sampler_2d_ext = 0x00008dd2
let gl_unsigned_int_sampler_3d_ext = 0x00008dd3
let gl_unsigned_int_sampler_cube_ext = 0x00008dd4
let gl_unsigned_int_sampler_2d_rect_ext = 0x00008dd5
let gl_unsigned_int_sampler_1d_array_ext = 0x00008dd6
let gl_unsigned_int_sampler_2d_array_ext = 0x00008dd7
let gl_unsigned_int_sampler_buffer_ext = 0x00008dd8
let gl_vertex_attrib_array_integer_ext = 0x000088fd
let gl_histogram_ext = 0x00008024
let gl_proxy_histogram_ext = 0x00008025
let gl_histogram_width_ext = 0x00008026
let gl_histogram_format_ext = 0x00008027
let gl_histogram_red_size_ext = 0x00008028
let gl_histogram_green_size_ext = 0x00008029
let gl_histogram_blue_size_ext = 0x0000802a
let gl_histogram_alpha_size_ext = 0x0000802b
let gl_histogram_luminance_size_ext = 0x0000802c
let gl_histogram_sink_ext = 0x0000802d
let gl_minmax_ext = 0x0000802e
let gl_minmax_format_ext = 0x0000802f
let gl_minmax_sink_ext = 0x00008030
let gl_fragment_material_ext = 0x00008349
let gl_fragment_normal_ext = 0x0000834a
let gl_fragment_color_ext = 0x0000834c
let gl_attenuation_ext = 0x0000834d
let gl_shadow_attenuation_ext = 0x0000834e
let gl_texture_application_mode_ext = 0x0000834f
let gl_texture_light_ext = 0x00008350
let gl_texture_material_face_ext = 0x00008351
let gl_texture_material_parameter_ext = 0x00008352
let gl_multisample_ext = 0x0000809d
let gl_sample_alpha_to_mask_ext = 0x0000809e
let gl_sample_alpha_to_one_ext = 0x0000809f
let gl_sample_mask_ext = 0x000080a0
let gl_1pass_ext = 0x000080a1
let gl_2pass_0_ext = 0x000080a2
let gl_2pass_1_ext = 0x000080a3
let gl_4pass_0_ext = 0x000080a4
let gl_4pass_1_ext = 0x000080a5
let gl_4pass_2_ext = 0x000080a6
let gl_4pass_3_ext = 0x000080a7
let gl_sample_buffers_ext = 0x000080a8
let gl_samples_ext = 0x000080a9
let gl_sample_mask_value_ext = 0x000080aa
let gl_sample_mask_invert_ext = 0x000080ab
let gl_sample_pattern_ext = 0x000080ac
let gl_multisample_bit_ext = 0x20000000
let gl_depth_stencil_ext = 0x000084f9
let gl_unsigned_int_24_8_ext = 0x000084fa
let gl_depth24_stencil8_ext = 0x000088f0
let gl_texture_stencil_size_ext = 0x000088f1
let gl_r11f_g11f_b10f_ext = 0x00008c3a
let gl_unsigned_int_10f_11f_11f_rev_ext = 0x00008c3b
let gl_rgba_signed_components_ext = 0x00008c3c
let gl_unsigned_byte_3_3_2_ext = 0x00008032
let gl_unsigned_short_4_4_4_4_ext = 0x00008033
let gl_unsigned_short_5_5_5_1_ext = 0x00008034
let gl_unsigned_int_8_8_8_8_ext = 0x00008035
let gl_unsigned_int_10_10_10_2_ext = 0x00008036
let gl_proxy_texture_3d_ext = 0x00008070
let gl_color_table_format_ext = 0x000080d8
let gl_color_table_width_ext = 0x000080d9
let gl_color_table_red_size_ext = 0x000080da
let gl_color_table_green_size_ext = 0x000080db
let gl_color_table_blue_size_ext = 0x000080dc
let gl_color_table_alpha_size_ext = 0x000080dd
let gl_color_table_luminance_size_ext = 0x000080de
let gl_color_table_intensity_size_ext = 0x000080df
let gl_texture_index_size_ext = 0x000080ed
let gl_pixel_transform_2d_ext = 0x00008330
let gl_pixel_mag_filter_ext = 0x00008331
let gl_pixel_min_filter_ext = 0x00008332
let gl_pixel_cubic_weight_ext = 0x00008333
let gl_cubic_ext = 0x00008334
let gl_average_ext = 0x00008335
let gl_pixel_transform_2d_stack_depth_ext = 0x00008336
let gl_max_pixel_transform_2d_stack_depth_ext = 0x00008337
let gl_pixel_transform_2d_matrix_ext = 0x00008338
let gl_point_size_min_ext = 0x00008126
let gl_point_size_max_ext = 0x00008127
let gl_point_fade_threshold_size_ext = 0x00008128
let gl_distance_attenuation_ext = 0x00008129
let gl_polygon_offset_ext = 0x00008037
let gl_polygon_offset_factor_ext = 0x00008038
let gl_polygon_offset_bias_ext = 0x00008039
let gl_light_model_color_control_ext = 0x000081f8
let gl_single_color_ext = 0x000081f9
let gl_separate_specular_color_ext = 0x000081fa
let gl_shared_texture_palette_ext = 0x000081fb
let gl_stencil_tag_bits_ext = 0x000088f2
let gl_stencil_clear_tag_value_ext = 0x000088f3
let gl_stencil_test_two_side_ext = 0x00008910
let gl_active_stencil_face_ext = 0x00008911
let gl_incr_wrap_ext = 0x00008507
let gl_decr_wrap_ext = 0x00008508
let gl_alpha4_ext = 0x0000803b
let gl_alpha8_ext = 0x0000803c
let gl_alpha12_ext = 0x0000803d
let gl_alpha16_ext = 0x0000803e
let gl_luminance4_ext = 0x0000803f
let gl_luminance8_ext = 0x00008040
let gl_luminance12_ext = 0x00008041
let gl_luminance16_ext = 0x00008042
let gl_luminance4_alpha4_ext = 0x00008043
let gl_luminance6_alpha2_ext = 0x00008044
let gl_luminance8_alpha8_ext = 0x00008045
let gl_luminance12_alpha4_ext = 0x00008046
let gl_luminance12_alpha12_ext = 0x00008047
let gl_luminance16_alpha16_ext = 0x00008048
let gl_intensity_ext = 0x00008049
let gl_intensity4_ext = 0x0000804a
let gl_intensity8_ext = 0x0000804b
let gl_intensity12_ext = 0x0000804c
let gl_intensity16_ext = 0x0000804d
let gl_rgb2_ext = 0x0000804e
let gl_rgb4_ext = 0x0000804f
let gl_rgb5_ext = 0x00008050
let gl_rgb8_ext = 0x00008051
let gl_rgb10_ext = 0x00008052
let gl_rgb12_ext = 0x00008053
let gl_rgb16_ext = 0x00008054
let gl_rgba2_ext = 0x00008055
let gl_rgba4_ext = 0x00008056
let gl_rgb5_a1_ext = 0x00008057
let gl_rgba8_ext = 0x00008058
let gl_rgb10_a2_ext = 0x00008059
let gl_rgba12_ext = 0x0000805a
let gl_rgba16_ext = 0x0000805b
let gl_texture_red_size_ext = 0x0000805c
let gl_texture_green_size_ext = 0x0000805d
let gl_texture_blue_size_ext = 0x0000805e
let gl_texture_alpha_size_ext = 0x0000805f
let gl_texture_luminance_size_ext = 0x00008060
let gl_texture_intensity_size_ext = 0x00008061
let gl_replace_ext = 0x00008062
let gl_proxy_texture_1d_ext = 0x00008063
let gl_proxy_texture_2d_ext = 0x00008064
let gl_pack_skip_images_ext = 0x0000806b
let gl_pack_image_height_ext = 0x0000806c
let gl_unpack_skip_images_ext = 0x0000806d
let gl_unpack_image_height_ext = 0x0000806e
let gl_texture_3d_ext = 0x0000806f
let gl_texture_depth_ext = 0x00008071
let gl_texture_wrap_r_ext = 0x00008072
let gl_max_3d_texture_size_ext = 0x00008073
let gl_texture_1d_array_ext = 0x00008c18
let gl_proxy_texture_1d_array_ext = 0x00008c19
let gl_texture_2d_array_ext = 0x00008c1a
let gl_proxy_texture_2d_array_ext = 0x00008c1b
let gl_texture_binding_1d_array_ext = 0x00008c1c
let gl_texture_binding_2d_array_ext = 0x00008c1d
let gl_max_array_texture_layers_ext = 0x000088ff
let gl_compare_ref_depth_to_texture_ext = 0x0000884e
let gl_texture_buffer_ext = 0x00008c2a
let gl_max_texture_buffer_size_ext = 0x00008c2b
let gl_texture_binding_buffer_ext = 0x00008c2c
let gl_texture_buffer_data_store_binding_ext = 0x00008c2d
let gl_texture_buffer_format_ext = 0x00008c2e
let gl_compressed_luminance_latc1_ext = 0x00008c70
let gl_compressed_signed_luminance_latc1_ext = 0x00008c71
let gl_compressed_luminance_alpha_latc2_ext = 0x00008c72
let gl_compressed_signed_luminance_alpha_latc2_ext = 0x00008c73
let gl_compressed_red_rgtc1_ext = 0x00008dbb
let gl_compressed_signed_red_rgtc1_ext = 0x00008dbc
let gl_compressed_red_green_rgtc2_ext = 0x00008dbd
let gl_compressed_signed_red_green_rgtc2_ext = 0x00008dbe
let gl_compressed_rgb_s3tc_dxt1_ext = 0x000083f0
let gl_compressed_rgba_s3tc_dxt1_ext = 0x000083f1
let gl_compressed_rgba_s3tc_dxt3_ext = 0x000083f2
let gl_compressed_rgba_s3tc_dxt5_ext = 0x000083f3
let gl_texture_env0_ext = 0x00000000
let gl_texture_env_shift_ext = 0x00000000
let gl_env_blend_ext = 0x00000000
let gl_env_add_ext = 0x00000000
let gl_env_replace_ext = 0x00000000
let gl_env_subtract_ext = 0x00000000
let gl_texture_env_mode_alpha_ext = 0x00000000
let gl_env_reverse_blend_ext = 0x00000000
let gl_env_reverse_subtract_ext = 0x00000000
let gl_env_copy_ext = 0x00000000
let gl_env_modulate_ext = 0x00000000
let gl_combine_ext = 0x00008570
let gl_combine_rgb_ext = 0x00008571
let gl_combine_alpha_ext = 0x00008572
let gl_rgb_scale_ext = 0x00008573
let gl_add_signed_ext = 0x00008574
let gl_interpolate_ext = 0x00008575
let gl_constant_ext = 0x00008576
let gl_primary_color_ext = 0x00008577
let gl_previous_ext = 0x00008578
let gl_source0_rgb_ext = 0x00008580
let gl_source1_rgb_ext = 0x00008581
let gl_source2_rgb_ext = 0x00008582
let gl_source0_alpha_ext = 0x00008588
let gl_source1_alpha_ext = 0x00008589
let gl_source2_alpha_ext = 0x0000858a
let gl_operand0_rgb_ext = 0x00008590
let gl_operand1_rgb_ext = 0x00008591
let gl_operand2_rgb_ext = 0x00008592
let gl_operand0_alpha_ext = 0x00008598
let gl_operand1_alpha_ext = 0x00008599
let gl_operand2_alpha_ext = 0x0000859a
let gl_dot3_rgb_ext = 0x00008740
let gl_dot3_rgba_ext = 0x00008741
let gl_texture_max_anisotropy_ext = 0x000084fe
let gl_max_texture_max_anisotropy_ext = 0x000084ff
let gl_rgba32ui_ext = 0x00008d70
let gl_rgb32ui_ext = 0x00008d71
let gl_alpha32ui_ext = 0x00008d72
let gl_intensity32ui_ext = 0x00008d73
let gl_luminance32ui_ext = 0x00008d74
let gl_luminance_alpha32ui_ext = 0x00008d75
let gl_rgba16ui_ext = 0x00008d76
let gl_rgb16ui_ext = 0x00008d77
let gl_alpha16ui_ext = 0x00008d78
let gl_intensity16ui_ext = 0x00008d79
let gl_luminance16ui_ext = 0x00008d7a
let gl_luminance_alpha16ui_ext = 0x00008d7b
let gl_rgba8ui_ext = 0x00008d7c
let gl_rgb8ui_ext = 0x00008d7d
let gl_alpha8ui_ext = 0x00008d7e
let gl_intensity8ui_ext = 0x00008d7f
let gl_luminance8ui_ext = 0x00008d80
let gl_luminance_alpha8ui_ext = 0x00008d81
let gl_rgba32i_ext = 0x00008d82
let gl_rgb32i_ext = 0x00008d83
let gl_alpha32i_ext = 0x00008d84
let gl_intensity32i_ext = 0x00008d85
let gl_luminance32i_ext = 0x00008d86
let gl_luminance_alpha32i_ext = 0x00008d87
let gl_rgba16i_ext = 0x00008d88
let gl_rgb16i_ext = 0x00008d89
let gl_alpha16i_ext = 0x00008d8a
let gl_intensity16i_ext = 0x00008d8b
let gl_luminance16i_ext = 0x00008d8c
let gl_luminance_alpha16i_ext = 0x00008d8d
let gl_rgba8i_ext = 0x00008d8e
let gl_rgb8i_ext = 0x00008d8f
let gl_alpha8i_ext = 0x00008d90
let gl_intensity8i_ext = 0x00008d91
let gl_luminance8i_ext = 0x00008d92
let gl_luminance_alpha8i_ext = 0x00008d93
let gl_red_integer_ext = 0x00008d94
let gl_green_integer_ext = 0x00008d95
let gl_blue_integer_ext = 0x00008d96
let gl_alpha_integer_ext = 0x00008d97
let gl_rgb_integer_ext = 0x00008d98
let gl_rgba_integer_ext = 0x00008d99
let gl_bgr_integer_ext = 0x00008d9a
let gl_bgra_integer_ext = 0x00008d9b
let gl_luminance_integer_ext = 0x00008d9c
let gl_luminance_alpha_integer_ext = 0x00008d9d
let gl_rgba_integer_mode_ext = 0x00008d9e
let gl_max_texture_lod_bias_ext = 0x000084fd
let gl_texture_filter_control_ext = 0x00008500
let gl_texture_lod_bias_ext = 0x00008501
let gl_mirror_clamp_ext = 0x00008742
let gl_mirror_clamp_to_edge_ext = 0x00008743
let gl_mirror_clamp_to_border_ext = 0x00008912
let gl_texture_priority_ext = 0x00008066
let gl_texture_resident_ext = 0x00008067
let gl_texture_1d_binding_ext = 0x00008068
let gl_texture_2d_binding_ext = 0x00008069
let gl_texture_3d_binding_ext = 0x0000806a
let gl_perturb_ext = 0x000085ae
let gl_texture_normal_ext = 0x000085af
let gl_rgb9_e5_ext = 0x00008c3d
let gl_unsigned_int_5_9_9_9_rev_ext = 0x00008c3e
let gl_texture_shared_size_ext = 0x00008c3f
let gl_srgb_ext = 0x00008c40
let gl_srgb8_ext = 0x00008c41
let gl_srgb_alpha_ext = 0x00008c42
let gl_srgb8_alpha8_ext = 0x00008c43
let gl_sluminance_alpha_ext = 0x00008c44
let gl_sluminance8_alpha8_ext = 0x00008c45
let gl_sluminance_ext = 0x00008c46
let gl_sluminance8_ext = 0x00008c47
let gl_compressed_srgb_ext = 0x00008c48
let gl_compressed_srgb_alpha_ext = 0x00008c49
let gl_compressed_sluminance_ext = 0x00008c4a
let gl_compressed_sluminance_alpha_ext = 0x00008c4b
let gl_compressed_srgb_s3tc_dxt1_ext = 0x00008c4c
let gl_compressed_srgb_alpha_s3tc_dxt1_ext = 0x00008c4d
let gl_compressed_srgb_alpha_s3tc_dxt3_ext = 0x00008c4e
let gl_compressed_srgb_alpha_s3tc_dxt5_ext = 0x00008c4f
let gl_double_ext = 0x0000140a
let gl_vertex_array_ext = 0x00008074
let gl_normal_array_ext = 0x00008075
let gl_color_array_ext = 0x00008076
let gl_index_array_ext = 0x00008077
let gl_texture_coord_array_ext = 0x00008078
let gl_edge_flag_array_ext = 0x00008079
let gl_vertex_array_size_ext = 0x0000807a
let gl_vertex_array_type_ext = 0x0000807b
let gl_vertex_array_stride_ext = 0x0000807c
let gl_vertex_array_count_ext = 0x0000807d
let gl_normal_array_type_ext = 0x0000807e
let gl_normal_array_stride_ext = 0x0000807f
let gl_normal_array_count_ext = 0x00008080
let gl_color_array_size_ext = 0x00008081
let gl_color_array_type_ext = 0x00008082
let gl_color_array_stride_ext = 0x00008083
let gl_color_array_count_ext = 0x00008084
let gl_index_array_type_ext = 0x00008085
let gl_index_array_stride_ext = 0x00008086
let gl_index_array_count_ext = 0x00008087
let gl_texture_coord_array_size_ext = 0x00008088
let gl_texture_coord_array_type_ext = 0x00008089
let gl_texture_coord_array_stride_ext = 0x0000808a
let gl_texture_coord_array_count_ext = 0x0000808b
let gl_edge_flag_array_stride_ext = 0x0000808c
let gl_edge_flag_array_count_ext = 0x0000808d
let gl_vertex_array_pointer_ext = 0x0000808e
let gl_normal_array_pointer_ext = 0x0000808f
let gl_color_array_pointer_ext = 0x00008090
let gl_index_array_pointer_ext = 0x00008091
let gl_texture_coord_array_pointer_ext = 0x00008092
let gl_edge_flag_array_pointer_ext = 0x00008093
let gl_modelview0_stack_depth_ext = 0x00000ba3
let gl_modelview0_matrix_ext = 0x00000ba6
let gl_modelview0_ext = 0x00001700
let gl_modelview1_stack_depth_ext = 0x00008502
let gl_modelview1_matrix_ext = 0x00008506
let gl_vertex_weighting_ext = 0x00008509
let gl_modelview1_ext = 0x0000850a
let gl_current_vertex_weight_ext = 0x0000850b
let gl_vertex_weight_array_ext = 0x0000850c
let gl_vertex_weight_array_size_ext = 0x0000850d
let gl_vertex_weight_array_type_ext = 0x0000850e
let gl_vertex_weight_array_stride_ext = 0x0000850f
let gl_vertex_weight_array_pointer_ext = 0x00008510
let gl_occlusion_test_result_hp = 0x00008166
let gl_occlusion_test_hp = 0x00008165
let gl_cull_vertex_ibm = 0x0001928a
let gl_raster_position_unclipped_ibm = 0x00019262
let gl_all_static_data_ibm = 0x00019294
let gl_static_vertex_array_ibm = 0x00019295
let gl_mirrored_repeat_ibm = 0x00008370
let gl_vertex_array_list_ibm = 0x0001929e
let gl_normal_array_list_ibm = 0x0001929f
let gl_color_array_list_ibm = 0x000192a0
let gl_index_array_list_ibm = 0x000192a1
let gl_texture_coord_array_list_ibm = 0x000192a2
let gl_edge_flag_array_list_ibm = 0x000192a3
let gl_fog_coordinate_array_list_ibm = 0x000192a4
let gl_secondary_color_array_list_ibm = 0x000192a5
let gl_vertex_array_list_stride_ibm = 0x000192a8
let gl_normal_array_list_stride_ibm = 0x000192a9
let gl_color_array_list_stride_ibm = 0x000192aa
let gl_index_array_list_stride_ibm = 0x000192ab
let gl_texture_coord_array_list_stride_ibm = 0x000192ac
let gl_edge_flag_array_list_stride_ibm = 0x000192ad
let gl_fog_coordinate_array_list_stride_ibm = 0x000192ae
let gl_secondary_color_array_list_stride_ibm = 0x000192af
let gl_red_min_clamp_ingr = 0x00008560
let gl_green_min_clamp_ingr = 0x00008561
let gl_blue_min_clamp_ingr = 0x00008562
let gl_alpha_min_clamp_ingr = 0x00008563
let gl_red_max_clamp_ingr = 0x00008564
let gl_green_max_clamp_ingr = 0x00008565
let gl_blue_max_clamp_ingr = 0x00008566
let gl_alpha_max_clamp_ingr = 0x00008567
let gl_interlace_read_ingr = 0x00008568
let gl_parallel_arrays_intel = 0x000083f4
let gl_vertex_array_parallel_pointers_intel = 0x000083f5
let gl_normal_array_parallel_pointers_intel = 0x000083f6
let gl_color_array_parallel_pointers_intel = 0x000083f7
let gl_texture_coord_array_parallel_pointers_intel = 0x000083f8
let gl_pack_invert_mesa = 0x00008758
let gl_texture_1d_stack_mesax = 0x00008759
let gl_texture_2d_stack_mesax = 0x0000875a
let gl_proxy_texture_1d_stack_mesax = 0x0000875b
let gl_proxy_texture_2d_stack_mesax = 0x0000875c
let gl_texture_1d_stack_binding_mesax = 0x0000875d
let gl_texture_2d_stack_binding_mesax = 0x0000875e
let gl_unsigned_short_8_8_mesa = 0x000085ba
let gl_unsigned_short_8_8_rev_mesa = 0x000085bb
let gl_ycbcr_mesa = 0x00008757
let gl_depth_stencil_to_rgba_nv = 0x0000886e
let gl_depth_stencil_to_bgra_nv = 0x0000886f
let gl_depth_component32f_nv = 0x00008dab
let gl_depth32f_stencil8_nv = 0x00008dac
let gl_float_32_unsigned_int_24_8_rev_nv = 0x00008dad
let gl_depth_buffer_float_mode_nv = 0x00008daf
let gl_depth_clamp_nv = 0x0000864f
let gl_sample_count_bits_nv = 0x00008864
let gl_current_sample_count_query_nv = 0x00008865
let gl_query_result_nv = 0x00008866
let gl_query_result_available_nv = 0x00008867
let gl_sample_count_nv = 0x00008914
let gl_eval_2d_nv = 0x000086c0
let gl_eval_triangular_2d_nv = 0x000086c1
let gl_map_tessellation_nv = 0x000086c2
let gl_map_attrib_u_order_nv = 0x000086c3
let gl_map_attrib_v_order_nv = 0x000086c4
let gl_eval_fractional_tessellation_nv = 0x000086c5
let gl_eval_vertex_attrib0_nv = 0x000086c6
let gl_eval_vertex_attrib1_nv = 0x000086c7
let gl_eval_vertex_attrib2_nv = 0x000086c8
let gl_eval_vertex_attrib3_nv = 0x000086c9
let gl_eval_vertex_attrib4_nv = 0x000086ca
let gl_eval_vertex_attrib5_nv = 0x000086cb
let gl_eval_vertex_attrib6_nv = 0x000086cc
let gl_eval_vertex_attrib7_nv = 0x000086cd
let gl_eval_vertex_attrib8_nv = 0x000086ce
let gl_eval_vertex_attrib9_nv = 0x000086cf
let gl_eval_vertex_attrib10_nv = 0x000086d0
let gl_eval_vertex_attrib11_nv = 0x000086d1
let gl_eval_vertex_attrib12_nv = 0x000086d2
let gl_eval_vertex_attrib13_nv = 0x000086d3
let gl_eval_vertex_attrib14_nv = 0x000086d4
let gl_eval_vertex_attrib15_nv = 0x000086d5
let gl_max_map_tessellation_nv = 0x000086d6
let gl_max_rational_eval_order_nv = 0x000086d7
let gl_all_completed_nv = 0x000084f2
let gl_fence_status_nv = 0x000084f3
let gl_fence_condition_nv = 0x000084f4
let gl_float_r_nv = 0x00008880
let gl_float_rg_nv = 0x00008881
let gl_float_rgb_nv = 0x00008882
let gl_float_rgba_nv = 0x00008883
let gl_float_r16_nv = 0x00008884
let gl_float_r32_nv = 0x00008885
let gl_float_rg16_nv = 0x00008886
let gl_float_rg32_nv = 0x00008887
let gl_float_rgb16_nv = 0x00008888
let gl_float_rgb32_nv = 0x00008889
let gl_float_rgba16_nv = 0x0000888a
let gl_float_rgba32_nv = 0x0000888b
let gl_texture_float_components_nv = 0x0000888c
let gl_float_clear_color_value_nv = 0x0000888d
let gl_float_rgba_mode_nv = 0x0000888e
let gl_fog_distance_mode_nv = 0x0000855a
let gl_eye_radial_nv = 0x0000855b
let gl_eye_plane_absolute_nv = 0x0000855c
let gl_max_fragment_program_local_parameters_nv = 0x00008868
let gl_fragment_program_nv = 0x00008870
let gl_max_texture_coords_nv = 0x00008871
let gl_max_texture_image_units_nv = 0x00008872
let gl_fragment_program_binding_nv = 0x00008873
let gl_program_error_string_nv = 0x00008874
let gl_renderbuffer_coverage_samples_nv = 0x00008cab
let gl_renderbuffer_color_samples_nv = 0x00008e10
let gl_max_multisample_coverage_modes_nv = 0x00008e11
let gl_multisample_coverage_modes_nv = 0x00008e12
let gl_geometry_program_nv = 0x00008c26
let gl_max_program_output_vertices_nv = 0x00008c27
let gl_max_program_total_output_components_nv = 0x00008c28
let gl_min_program_texel_offset_nv = 0x00008904
let gl_max_program_texel_offset_nv = 0x00008905
let gl_program_attrib_components_nv = 0x00008906
let gl_program_result_components_nv = 0x00008907
let gl_max_program_attrib_components_nv = 0x00008908
let gl_max_program_result_components_nv = 0x00008909
let gl_max_program_generic_attribs_nv = 0x00008da5
let gl_max_program_generic_results_nv = 0x00008da6
let gl_half_float_nv = 0x0000140b
let gl_max_shininess_nv = 0x00008504
let gl_max_spot_exponent_nv = 0x00008505
let gl_multisample_filter_hint_nv = 0x00008534
let gl_pixel_counter_bits_nv = 0x00008864
let gl_current_occlusion_query_id_nv = 0x00008865
let gl_pixel_count_nv = 0x00008866
let gl_pixel_count_available_nv = 0x00008867
let gl_depth_stencil_nv = 0x000084f9
let gl_unsigned_int_24_8_nv = 0x000084fa
let gl_vertex_program_parameter_buffer_nv = 0x00008da2
let gl_geometry_program_parameter_buffer_nv = 0x00008da3
let gl_fragment_program_parameter_buffer_nv = 0x00008da4
let gl_max_program_parameter_buffer_bindings_nv = 0x00008da0
let gl_max_program_parameter_buffer_size_nv = 0x00008da1
let gl_write_pixel_data_range_nv = 0x00008878
let gl_read_pixel_data_range_nv = 0x00008879
let gl_write_pixel_data_range_length_nv = 0x0000887a
let gl_read_pixel_data_range_length_nv = 0x0000887b
let gl_write_pixel_data_range_pointer_nv = 0x0000887c
let gl_read_pixel_data_range_pointer_nv = 0x0000887d
let gl_point_sprite_nv = 0x00008861
let gl_coord_replace_nv = 0x00008862
let gl_point_sprite_r_mode_nv = 0x00008863
let gl_primitive_restart_nv = 0x00008558
let gl_primitive_restart_index_nv = 0x00008559
let gl_register_combiners_nv = 0x00008522
let gl_variable_a_nv = 0x00008523
let gl_variable_b_nv = 0x00008524
let gl_variable_c_nv = 0x00008525
let gl_variable_d_nv = 0x00008526
let gl_variable_e_nv = 0x00008527
let gl_variable_f_nv = 0x00008528
let gl_variable_g_nv = 0x00008529
let gl_constant_color0_nv = 0x0000852a
let gl_constant_color1_nv = 0x0000852b
let gl_primary_color_nv = 0x0000852c
let gl_secondary_color_nv = 0x0000852d
let gl_spare0_nv = 0x0000852e
let gl_spare1_nv = 0x0000852f
let gl_discard_nv = 0x00008530
let gl_e_times_f_nv = 0x00008531
let gl_spare0_plus_secondary_color_nv = 0x00008532
let gl_unsigned_identity_nv = 0x00008536
let gl_unsigned_invert_nv = 0x00008537
let gl_expand_normal_nv = 0x00008538
let gl_expand_negate_nv = 0x00008539
let gl_half_bias_normal_nv = 0x0000853a
let gl_half_bias_negate_nv = 0x0000853b
let gl_signed_identity_nv = 0x0000853c
let gl_signed_negate_nv = 0x0000853d
let gl_scale_by_two_nv = 0x0000853e
let gl_scale_by_four_nv = 0x0000853f
let gl_scale_by_one_half_nv = 0x00008540
let gl_bias_by_negative_one_half_nv = 0x00008541
let gl_combiner_input_nv = 0x00008542
let gl_combiner_mapping_nv = 0x00008543
let gl_combiner_component_usage_nv = 0x00008544
let gl_combiner_ab_dot_product_nv = 0x00008545
let gl_combiner_cd_dot_product_nv = 0x00008546
let gl_combiner_mux_sum_nv = 0x00008547
let gl_combiner_scale_nv = 0x00008548
let gl_combiner_bias_nv = 0x00008549
let gl_combiner_ab_output_nv = 0x0000854a
let gl_combiner_cd_output_nv = 0x0000854b
let gl_combiner_sum_output_nv = 0x0000854c
let gl_max_general_combiners_nv = 0x0000854d
let gl_num_general_combiners_nv = 0x0000854e
let gl_color_sum_clamp_nv = 0x0000854f
let gl_combiner0_nv = 0x00008550
let gl_combiner1_nv = 0x00008551
let gl_combiner2_nv = 0x00008552
let gl_combiner3_nv = 0x00008553
let gl_combiner4_nv = 0x00008554
let gl_combiner5_nv = 0x00008555
let gl_combiner6_nv = 0x00008556
let gl_combiner7_nv = 0x00008557
let gl_per_stage_constants_nv = 0x00008535
let gl_emboss_light_nv = 0x0000855d
let gl_emboss_constant_nv = 0x0000855e
let gl_emboss_map_nv = 0x0000855f
let gl_normal_map_nv = 0x00008511
let gl_reflection_map_nv = 0x00008512
let gl_combine4_nv = 0x00008503
let gl_source3_rgb_nv = 0x00008583
let gl_source3_alpha_nv = 0x0000858b
let gl_operand3_rgb_nv = 0x00008593
let gl_operand3_alpha_nv = 0x0000859b
let gl_texture_unsigned_remap_mode_nv = 0x0000888f
let gl_texture_rectangle_nv = 0x000084f5
let gl_texture_binding_rectangle_nv = 0x000084f6
let gl_proxy_texture_rectangle_nv = 0x000084f7
let gl_max_rectangle_texture_size_nv = 0x000084f8
let gl_offset_texture_rectangle_nv = 0x0000864c
let gl_offset_texture_rectangle_scale_nv = 0x0000864d
let gl_dot_product_texture_rectangle_nv = 0x0000864e
let gl_rgba_unsigned_dot_product_mapping_nv = 0x000086d9
let gl_unsigned_int_s8_s8_8_8_nv = 0x000086da
let gl_unsigned_int_8_8_s8_s8_rev_nv = 0x000086db
let gl_dsdt_mag_intensity_nv = 0x000086dc
let gl_shader_consistent_nv = 0x000086dd
let gl_texture_shader_nv = 0x000086de
let gl_shader_operation_nv = 0x000086df
let gl_cull_modes_nv = 0x000086e0
let gl_offset_texture_matrix_nv = 0x000086e1
let gl_offset_texture_scale_nv = 0x000086e2
let gl_offset_texture_bias_nv = 0x000086e3
let gl_previous_texture_input_nv = 0x000086e4
let gl_const_eye_nv = 0x000086e5
let gl_pass_through_nv = 0x000086e6
let gl_cull_fragment_nv = 0x000086e7
let gl_offset_texture_2d_nv = 0x000086e8
let gl_dependent_ar_texture_2d_nv = 0x000086e9
let gl_dependent_gb_texture_2d_nv = 0x000086ea
let gl_dot_product_nv = 0x000086ec
let gl_dot_product_depth_replace_nv = 0x000086ed
let gl_dot_product_texture_2d_nv = 0x000086ee
let gl_dot_product_texture_cube_map_nv = 0x000086f0
let gl_dot_product_diffuse_cube_map_nv = 0x000086f1
let gl_dot_product_reflect_cube_map_nv = 0x000086f2
let gl_dot_product_const_eye_reflect_cube_map_nv = 0x000086f3
let gl_hilo_nv = 0x000086f4
let gl_dsdt_nv = 0x000086f5
let gl_dsdt_mag_nv = 0x000086f6
let gl_dsdt_mag_vib_nv = 0x000086f7
let gl_hilo16_nv = 0x000086f8
let gl_signed_hilo_nv = 0x000086f9
let gl_signed_hilo16_nv = 0x000086fa
let gl_signed_rgba_nv = 0x000086fb
let gl_signed_rgba8_nv = 0x000086fc
let gl_signed_rgb_nv = 0x000086fe
let gl_signed_rgb8_nv = 0x000086ff
let gl_signed_luminance_nv = 0x00008701
let gl_signed_luminance8_nv = 0x00008702
let gl_signed_luminance_alpha_nv = 0x00008703
let gl_signed_luminance8_alpha8_nv = 0x00008704
let gl_signed_alpha_nv = 0x00008705
let gl_signed_alpha8_nv = 0x00008706
let gl_signed_intensity_nv = 0x00008707
let gl_signed_intensity8_nv = 0x00008708
let gl_dsdt8_nv = 0x00008709
let gl_dsdt8_mag8_nv = 0x0000870a
let gl_dsdt8_mag8_intensity8_nv = 0x0000870b
let gl_signed_rgb_unsigned_alpha_nv = 0x0000870c
let gl_signed_rgb8_unsigned_alpha8_nv = 0x0000870d
let gl_hi_scale_nv = 0x0000870e
let gl_lo_scale_nv = 0x0000870f
let gl_ds_scale_nv = 0x00008710
let gl_dt_scale_nv = 0x00008711
let gl_magnitude_scale_nv = 0x00008712
let gl_vibrance_scale_nv = 0x00008713
let gl_hi_bias_nv = 0x00008714
let gl_lo_bias_nv = 0x00008715
let gl_ds_bias_nv = 0x00008716
let gl_dt_bias_nv = 0x00008717
let gl_magnitude_bias_nv = 0x00008718
let gl_vibrance_bias_nv = 0x00008719
let gl_texture_border_values_nv = 0x0000871a
let gl_texture_hi_size_nv = 0x0000871b
let gl_texture_lo_size_nv = 0x0000871c
let gl_texture_ds_size_nv = 0x0000871d
let gl_texture_dt_size_nv = 0x0000871e
let gl_texture_mag_size_nv = 0x0000871f
let gl_dot_product_texture_3d_nv = 0x000086ef
let gl_offset_projective_texture_2d_nv = 0x00008850
let gl_offset_projective_texture_2d_scale_nv = 0x00008851
let gl_offset_projective_texture_rectangle_nv = 0x00008852
let gl_offset_projective_texture_rectangle_scale_nv = 0x00008853
let gl_offset_hilo_texture_2d_nv = 0x00008854
let gl_offset_hilo_texture_rectangle_nv = 0x00008855
let gl_offset_hilo_projective_texture_2d_nv = 0x00008856
let gl_offset_hilo_projective_texture_rectangle_nv = 0x00008857
let gl_dependent_hilo_texture_2d_nv = 0x00008858
let gl_dependent_rgb_texture_3d_nv = 0x00008859
let gl_dependent_rgb_texture_cube_map_nv = 0x0000885a
let gl_dot_product_pass_through_nv = 0x0000885b
let gl_dot_product_texture_1d_nv = 0x0000885c
let gl_dot_product_affine_depth_replace_nv = 0x0000885d
let gl_hilo8_nv = 0x0000885e
let gl_signed_hilo8_nv = 0x0000885f
let gl_force_blue_to_one_nv = 0x00008860
let gl_back_primary_color_nv = 0x00008c77
let gl_back_secondary_color_nv = 0x00008c78
let gl_texture_coord_nv = 0x00008c79
let gl_clip_distance_nv = 0x00008c7a
let gl_vertex_id_nv = 0x00008c7b
let gl_primitive_id_nv = 0x00008c7c
let gl_generic_attrib_nv = 0x00008c7d
let gl_transform_feedback_attribs_nv = 0x00008c7e
let gl_transform_feedback_buffer_mode_nv = 0x00008c7f
let gl_max_transform_feedback_separate_components_nv = 0x00008c80
let gl_active_varyings_nv = 0x00008c81
let gl_active_varying_max_length_nv = 0x00008c82
let gl_transform_feedback_varyings_nv = 0x00008c83
let gl_transform_feedback_buffer_start_nv = 0x00008c84
let gl_transform_feedback_buffer_size_nv = 0x00008c85
let gl_transform_feedback_record_nv = 0x00008c86
let gl_primitives_generated_nv = 0x00008c87
let gl_transform_feedback_primitives_written_nv = 0x00008c88
let gl_rasterizer_discard_nv = 0x00008c89
let gl_max_transform_feedback_interleaved_components_nv = 0x00008c8a
let gl_max_transform_feedback_separate_attribs_nv = 0x00008c8b
let gl_interleaved_attribs_nv = 0x00008c8c
let gl_separate_attribs_nv = 0x00008c8d
let gl_transform_feedback_buffer_nv = 0x00008c8e
let gl_transform_feedback_buffer_binding_nv = 0x00008c8f
let gl_vertex_array_range_nv = 0x0000851d
let gl_vertex_array_range_length_nv = 0x0000851e
let gl_vertex_array_range_valid_nv = 0x0000851f
let gl_max_vertex_array_range_element_nv = 0x00008520
let gl_vertex_array_range_pointer_nv = 0x00008521
let gl_vertex_array_range_without_flush_nv = 0x00008533
let gl_vertex_program_nv = 0x00008620
let gl_vertex_state_program_nv = 0x00008621
let gl_attrib_array_size_nv = 0x00008623
let gl_attrib_array_stride_nv = 0x00008624
let gl_attrib_array_type_nv = 0x00008625
let gl_current_attrib_nv = 0x00008626
let gl_program_length_nv = 0x00008627
let gl_program_string_nv = 0x00008628
let gl_modelview_projection_nv = 0x00008629
let gl_identity_nv = 0x0000862a
let gl_inverse_nv = 0x0000862b
let gl_transpose_nv = 0x0000862c
let gl_inverse_transpose_nv = 0x0000862d
let gl_max_track_matrix_stack_depth_nv = 0x0000862e
let gl_max_track_matrices_nv = 0x0000862f
let gl_matrix0_nv = 0x00008630
let gl_matrix1_nv = 0x00008631
let gl_matrix2_nv = 0x00008632
let gl_matrix3_nv = 0x00008633
let gl_matrix4_nv = 0x00008634
let gl_matrix5_nv = 0x00008635
let gl_matrix6_nv = 0x00008636
let gl_matrix7_nv = 0x00008637
let gl_current_matrix_stack_depth_nv = 0x00008640
let gl_current_matrix_nv = 0x00008641
let gl_vertex_program_point_size_nv = 0x00008642
let gl_vertex_program_two_side_nv = 0x00008643
let gl_program_parameter_nv = 0x00008644
let gl_attrib_array_pointer_nv = 0x00008645
let gl_program_target_nv = 0x00008646
let gl_program_resident_nv = 0x00008647
let gl_track_matrix_nv = 0x00008648
let gl_track_matrix_transform_nv = 0x00008649
let gl_vertex_program_binding_nv = 0x0000864a
let gl_program_error_position_nv = 0x0000864b
let gl_vertex_attrib_array0_nv = 0x00008650
let gl_vertex_attrib_array1_nv = 0x00008651
let gl_vertex_attrib_array2_nv = 0x00008652
let gl_vertex_attrib_array3_nv = 0x00008653
let gl_vertex_attrib_array4_nv = 0x00008654
let gl_vertex_attrib_array5_nv = 0x00008655
let gl_vertex_attrib_array6_nv = 0x00008656
let gl_vertex_attrib_array7_nv = 0x00008657
let gl_vertex_attrib_array8_nv = 0x00008658
let gl_vertex_attrib_array9_nv = 0x00008659
let gl_vertex_attrib_array10_nv = 0x0000865a
let gl_vertex_attrib_array11_nv = 0x0000865b
let gl_vertex_attrib_array12_nv = 0x0000865c
let gl_vertex_attrib_array13_nv = 0x0000865d
let gl_vertex_attrib_array14_nv = 0x0000865e
let gl_vertex_attrib_array15_nv = 0x0000865f
let gl_map1_vertex_attrib0_4_nv = 0x00008660
let gl_map1_vertex_attrib1_4_nv = 0x00008661
let gl_map1_vertex_attrib2_4_nv = 0x00008662
let gl_map1_vertex_attrib3_4_nv = 0x00008663
let gl_map1_vertex_attrib4_4_nv = 0x00008664
let gl_map1_vertex_attrib5_4_nv = 0x00008665
let gl_map1_vertex_attrib6_4_nv = 0x00008666
let gl_map1_vertex_attrib7_4_nv = 0x00008667
let gl_map1_vertex_attrib8_4_nv = 0x00008668
let gl_map1_vertex_attrib9_4_nv = 0x00008669
let gl_map1_vertex_attrib10_4_nv = 0x0000866a
let gl_map1_vertex_attrib11_4_nv = 0x0000866b
let gl_map1_vertex_attrib12_4_nv = 0x0000866c
let gl_map1_vertex_attrib13_4_nv = 0x0000866d
let gl_map1_vertex_attrib14_4_nv = 0x0000866e
let gl_map1_vertex_attrib15_4_nv = 0x0000866f
let gl_map2_vertex_attrib0_4_nv = 0x00008670
let gl_map2_vertex_attrib1_4_nv = 0x00008671
let gl_map2_vertex_attrib2_4_nv = 0x00008672
let gl_map2_vertex_attrib3_4_nv = 0x00008673
let gl_map2_vertex_attrib4_4_nv = 0x00008674
let gl_map2_vertex_attrib5_4_nv = 0x00008675
let gl_map2_vertex_attrib6_4_nv = 0x00008676
let gl_map2_vertex_attrib7_4_nv = 0x00008677
let gl_map2_vertex_attrib8_4_nv = 0x00008678
let gl_map2_vertex_attrib9_4_nv = 0x00008679
let gl_map2_vertex_attrib10_4_nv = 0x0000867a
let gl_map2_vertex_attrib11_4_nv = 0x0000867b
let gl_map2_vertex_attrib12_4_nv = 0x0000867c
let gl_map2_vertex_attrib13_4_nv = 0x0000867d
let gl_map2_vertex_attrib14_4_nv = 0x0000867e
let gl_map2_vertex_attrib15_4_nv = 0x0000867f
let gl_max_vertex_texture_image_units_arb = 0x00008b4c
let gl_palette4_rgb8_oes = 0x00008b90
let gl_palette4_rgba8_oes = 0x00008b91
let gl_palette4_r5_g6_b5_oes = 0x00008b92
let gl_palette4_rgba4_oes = 0x00008b93
let gl_palette4_rgb5_a1_oes = 0x00008b94
let gl_palette8_rgb8_oes = 0x00008b95
let gl_palette8_rgba8_oes = 0x00008b96
let gl_palette8_r5_g6_b5_oes = 0x00008b97
let gl_palette8_rgba4_oes = 0x00008b98
let gl_palette8_rgb5_a1_oes = 0x00008b99
let gl_implementation_color_read_type_oes = 0x00008b9a
let gl_implementation_color_read_format_oes = 0x00008b9b
let gl_interlace_oml = 0x00008980
let gl_interlace_read_oml = 0x00008981
let gl_pack_resample_oml = 0x00008984
let gl_unpack_resample_oml = 0x00008985
let gl_resample_replicate_oml = 0x00008986
let gl_resample_zero_fill_oml = 0x00008987
let gl_resample_average_oml = 0x00008988
let gl_resample_decimate_oml = 0x00008989
let gl_format_subsample_24_24_oml = 0x00008982
let gl_format_subsample_244_244_oml = 0x00008983
let gl_prefer_doublebuffer_hint_pgi = 0x0001a1f8
let gl_conserve_memory_hint_pgi = 0x0001a1fd
let gl_reclaim_memory_hint_pgi = 0x0001a1fe
let gl_native_graphics_handle_pgi = 0x0001a202
let gl_native_graphics_begin_hint_pgi = 0x0001a203
let gl_native_graphics_end_hint_pgi = 0x0001a204
let gl_always_fast_hint_pgi = 0x0001a20c
let gl_always_soft_hint_pgi = 0x0001a20d
let gl_allow_draw_obj_hint_pgi = 0x0001a20e
let gl_allow_draw_win_hint_pgi = 0x0001a20f
let gl_allow_draw_frg_hint_pgi = 0x0001a210
let gl_allow_draw_mem_hint_pgi = 0x0001a211
let gl_strict_depthfunc_hint_pgi = 0x0001a216
let gl_strict_lighting_hint_pgi = 0x0001a217
let gl_strict_scissor_hint_pgi = 0x0001a218
let gl_full_stipple_hint_pgi = 0x0001a219
let gl_clip_near_hint_pgi = 0x0001a220
let gl_clip_far_hint_pgi = 0x0001a221
let gl_wide_line_hint_pgi = 0x0001a222
let gl_back_normals_hint_pgi = 0x0001a223
let gl_vertex23_bit_pgi = 0x00000004
let gl_vertex4_bit_pgi = 0x00000008
let gl_color3_bit_pgi = 0x00010000
let gl_color4_bit_pgi = 0x00020000
let gl_edgeflag_bit_pgi = 0x00040000
let gl_index_bit_pgi = 0x00080000
let gl_mat_ambient_bit_pgi = 0x00100000
let gl_vertex_data_hint_pgi = 0x0001a22a
let gl_vertex_consistent_hint_pgi = 0x0001a22b
let gl_material_side_hint_pgi = 0x0001a22c
let gl_max_vertex_hint_pgi = 0x0001a22d
let gl_mat_ambient_and_diffuse_bit_pgi = 0x00200000
let gl_mat_diffuse_bit_pgi = 0x00400000
let gl_mat_emission_bit_pgi = 0x00800000
let gl_mat_color_indexes_bit_pgi = 0x01000000
let gl_mat_shininess_bit_pgi = 0x02000000
let gl_mat_specular_bit_pgi = 0x04000000
let gl_normal_bit_pgi = 0x08000000
let gl_texcoord1_bit_pgi = 0x10000000
let gl_texcoord2_bit_pgi = 0x20000000
let gl_texcoord3_bit_pgi = 0x40000000
let gl_screen_coordinates_rend = 0x00008490
let gl_inverted_screen_w_rend = 0x00008491
let gl_rgb_s3tc = 0x000083a0
let gl_rgb4_s3tc = 0x000083a1
let gl_rgba_s3tc = 0x000083a2
let gl_rgba4_s3tc = 0x000083a3
let gl_rgba_dxt5_s3tc = 0x000083a4
let gl_rgba4_dxt5_s3tc = 0x000083a5
let gl_color_matrix_sgi = 0x000080b1
let gl_color_matrix_stack_depth_sgi = 0x000080b2
let gl_max_color_matrix_stack_depth_sgi = 0x000080b3
let gl_post_color_matrix_red_scale_sgi = 0x000080b4
let gl_post_color_matrix_green_scale_sgi = 0x000080b5
let gl_post_color_matrix_blue_scale_sgi = 0x000080b6
let gl_post_color_matrix_alpha_scale_sgi = 0x000080b7
let gl_post_color_matrix_red_bias_sgi = 0x000080b8
let gl_post_color_matrix_green_bias_sgi = 0x000080b9
let gl_post_color_matrix_blue_bias_sgi = 0x000080ba
let gl_post_color_matrix_alpha_bias_sgi = 0x000080bb
let gl_color_table_sgi = 0x000080d0
let gl_post_convolution_color_table_sgi = 0x000080d1
let gl_post_color_matrix_color_table_sgi = 0x000080d2
let gl_proxy_color_table_sgi = 0x000080d3
let gl_proxy_post_convolution_color_table_sgi = 0x000080d4
let gl_proxy_post_color_matrix_color_table_sgi = 0x000080d5
let gl_color_table_scale_sgi = 0x000080d6
let gl_color_table_bias_sgi = 0x000080d7
let gl_color_table_format_sgi = 0x000080d8
let gl_color_table_width_sgi = 0x000080d9
let gl_color_table_red_size_sgi = 0x000080da
let gl_color_table_green_size_sgi = 0x000080db
let gl_color_table_blue_size_sgi = 0x000080dc
let gl_color_table_alpha_size_sgi = 0x000080dd
let gl_color_table_luminance_size_sgi = 0x000080de
let gl_color_table_intensity_size_sgi = 0x000080df
let gl_extended_range_sgis = 0x000085a5
let gl_min_red_sgis = 0x000085a6
let gl_max_red_sgis = 0x000085a7
let gl_min_green_sgis = 0x000085a8
let gl_max_green_sgis = 0x000085a9
let gl_min_blue_sgis = 0x000085aa
let gl_max_blue_sgis = 0x000085ab
let gl_min_alpha_sgis = 0x000085ac
let gl_max_alpha_sgis = 0x000085ad
let gl_generate_mipmap_sgis = 0x00008191
let gl_generate_mipmap_hint_sgis = 0x00008192
let gl_multisample_sgis = 0x0000809d
let gl_sample_alpha_to_mask_sgis = 0x0000809e
let gl_sample_alpha_to_one_sgis = 0x0000809f
let gl_sample_mask_sgis = 0x000080a0
let gl_1pass_sgis = 0x000080a1
let gl_2pass_0_sgis = 0x000080a2
let gl_2pass_1_sgis = 0x000080a3
let gl_4pass_0_sgis = 0x000080a4
let gl_4pass_1_sgis = 0x000080a5
let gl_4pass_2_sgis = 0x000080a6
let gl_4pass_3_sgis = 0x000080a7
let gl_sample_buffers_sgis = 0x000080a8
let gl_samples_sgis = 0x000080a9
let gl_sample_mask_value_sgis = 0x000080aa
let gl_sample_mask_invert_sgis = 0x000080ab
let gl_sample_pattern_sgis = 0x000080ac
let gl_clamp_to_border_sgis = 0x0000812d
let gl_clamp_to_edge_sgis = 0x0000812f
let gl_texture_min_lod_sgis = 0x0000813a
let gl_texture_max_lod_sgis = 0x0000813b
let gl_texture_base_level_sgis = 0x0000813c
let gl_texture_max_level_sgis = 0x0000813d
let gl_texture_color_table_sgi = 0x000080bc
let gl_proxy_texture_color_table_sgi = 0x000080bd
let gl_async_marker_sgix = 0x00008329
let gl_async_histogram_sgix = 0x0000832c
let gl_max_async_histogram_sgix = 0x0000832d
let gl_async_tex_image_sgix = 0x0000835c
let gl_async_draw_pixels_sgix = 0x0000835d
let gl_async_read_pixels_sgix = 0x0000835e
let gl_max_async_tex_image_sgix = 0x0000835f
let gl_max_async_draw_pixels_sgix = 0x00008360
let gl_max_async_read_pixels_sgix = 0x00008361
let gl_alpha_min_sgix = 0x00008320
let gl_alpha_max_sgix = 0x00008321
let gl_depth_component16_sgix = 0x000081a5
let gl_depth_component24_sgix = 0x000081a6
let gl_depth_component32_sgix = 0x000081a7
let gl_fog_offset_sgix = 0x00008198
let gl_fog_offset_value_sgix = 0x00008199
let gl_texture_fog_sgix = 0x00000000
let gl_fog_patchy_factor_sgix = 0x00000000
let gl_fragment_fog_sgix = 0x00000000
let gl_interlace_sgix = 0x00008094
let gl_pack_resample_sgix = 0x0000842e
let gl_unpack_resample_sgix = 0x0000842f
let gl_resample_decimate_sgix = 0x00008430
let gl_resample_replicate_sgix = 0x00008433
let gl_resample_zero_fill_sgix = 0x00008434
let gl_texture_compare_sgix = 0x0000819a
let gl_texture_compare_operator_sgix = 0x0000819b
let gl_texture_lequal_r_sgix = 0x0000819c
let gl_texture_gequal_r_sgix = 0x0000819d
let gl_shadow_ambient_sgix = 0x000080bf
let gl_texture_max_clamp_s_sgix = 0x00008369
let gl_texture_max_clamp_t_sgix = 0x0000836a
let gl_texture_max_clamp_r_sgix = 0x0000836b
let gl_texture_multi_buffer_hint_sgix = 0x0000812e
let gl_rgb_signed_sgix = 0x000085e0
let gl_rgba_signed_sgix = 0x000085e1
let gl_alpha_signed_sgix = 0x000085e2
let gl_luminance_signed_sgix = 0x000085e3
let gl_intensity_signed_sgix = 0x000085e4
let gl_luminance_alpha_signed_sgix = 0x000085e5
let gl_rgb16_signed_sgix = 0x000085e6
let gl_rgba16_signed_sgix = 0x000085e7
let gl_alpha16_signed_sgix = 0x000085e8
let gl_luminance16_signed_sgix = 0x000085e9
let gl_intensity16_signed_sgix = 0x000085ea
let gl_luminance16_alpha16_signed_sgix = 0x000085eb
let gl_rgb_extended_range_sgix = 0x000085ec
let gl_rgba_extended_range_sgix = 0x000085ed
let gl_alpha_extended_range_sgix = 0x000085ee
let gl_luminance_extended_range_sgix = 0x000085ef
let gl_intensity_extended_range_sgix = 0x000085f0
let gl_luminance_alpha_extended_range_sgix = 0x000085f1
let gl_rgb16_extended_range_sgix = 0x000085f2
let gl_rgba16_extended_range_sgix = 0x000085f3
let gl_alpha16_extended_range_sgix = 0x000085f4
let gl_luminance16_extended_range_sgix = 0x000085f5
let gl_intensity16_extended_range_sgix = 0x000085f6
let gl_luminance16_alpha16_extended_range_sgix = 0x000085f7
let gl_min_luminance_sgis = 0x000085f8
let gl_max_luminance_sgis = 0x000085f9
let gl_min_intensity_sgis = 0x000085fa
let gl_max_intensity_sgis = 0x000085fb
let gl_post_texture_filter_bias_sgix = 0x00008179
let gl_post_texture_filter_scale_sgix = 0x0000817a
let gl_post_texture_filter_bias_range_sgix = 0x0000817b
let gl_post_texture_filter_scale_range_sgix = 0x0000817c
let gl_vertex_preclip_sgix = 0x000083ee
let gl_vertex_preclip_hint_sgix = 0x000083ef
let gl_wrap_border_sun = 0x000081d4
let gl_global_alpha_sun = 0x000081d9
let gl_global_alpha_factor_sun = 0x000081da
let gl_quad_mesh_sun = 0x00008614
let gl_triangle_mesh_sun = 0x00008615
let gl_slice_accum_sun = 0x000085cc
let gl_restart_sun = 0x00000001
let gl_replace_middle_sun = 0x00000002
let gl_replace_oldest_sun = 0x00000003
let gl_triangle_list_sun = 0x000081d7
let gl_replacement_code_sun = 0x000081d8
let gl_replacement_code_array_sun = 0x000085c0
let gl_replacement_code_array_type_sun = 0x000085c1
let gl_replacement_code_array_stride_sun = 0x000085c2
let gl_replacement_code_array_pointer_sun = 0x000085c3
let gl_r1ui_v3f_sun = 0x000085c4
let gl_r1ui_c4ub_v3f_sun = 0x000085c5
let gl_r1ui_c3f_v3f_sun = 0x000085c6
let gl_r1ui_n3f_v3f_sun = 0x000085c7
let gl_r1ui_c4f_n3f_v3f_sun = 0x000085c8
let gl_r1ui_t2f_v3f_sun = 0x000085c9
let gl_r1ui_t2f_n3f_v3f_sun = 0x000085ca
let gl_r1ui_t2f_c4f_n3f_v3f_sun = 0x000085cb
let gl_unpack_constant_data_sunx = 0x000081d5
let gl_texture_constant_data_sunx = 0x000081d6
let gl_phong_win = 0x000080ea
let gl_phong_hint_win = 0x000080eb
let gl_fog_specular_texture_win = 0x000080ec
let gl_accum = 0x00000100
let gl_load = 0x00000101
let gl_return = 0x00000102
let gl_mult = 0x00000103
let gl_add = 0x00000104
let gl_never = 0x00000200
let gl_less = 0x00000201
let gl_equal = 0x00000202
let gl_lequal = 0x00000203
let gl_greater = 0x00000204
let gl_notequal = 0x00000205
let gl_gequal = 0x00000206
let gl_always = 0x00000207
let gl_current_bit = 0x00000001
let gl_point_bit = 0x00000002
let gl_line_bit = 0x00000004
let gl_polygon_bit = 0x00000008
let gl_polygon_stipple_bit = 0x00000010
let gl_pixel_mode_bit = 0x00000020
let gl_lighting_bit = 0x00000040
let gl_fog_bit = 0x00000080
let gl_depth_buffer_bit = 0x00000100
let gl_accum_buffer_bit = 0x00000200
let gl_stencil_buffer_bit = 0x00000400
let gl_viewport_bit = 0x00000800
let gl_transform_bit = 0x00001000
let gl_enable_bit = 0x00002000
let gl_color_buffer_bit = 0x00004000
let gl_hint_bit = 0x00008000
let gl_eval_bit = 0x00010000
let gl_list_bit = 0x00020000
let gl_texture_bit = 0x00040000
let gl_scissor_bit = 0x00080000
let gl_all_attrib_bits = 0x000fffff
let gl_points = 0x00000000
let gl_lines = 0x00000001
let gl_line_loop = 0x00000002
let gl_line_strip = 0x00000003
let gl_triangles = 0x00000004
let gl_triangle_strip = 0x00000005
let gl_triangle_fan = 0x00000006
let gl_quads = 0x00000007
let gl_quad_strip = 0x00000008
let gl_polygon = 0x00000009
let gl_zero = 0x00000000
let gl_one = 0x00000001
let gl_src_color = 0x00000300
let gl_one_minus_src_color = 0x00000301
let gl_src_alpha = 0x00000302
let gl_one_minus_src_alpha = 0x00000303
let gl_dst_alpha = 0x00000304
let gl_one_minus_dst_alpha = 0x00000305
let gl_dst_color = 0x00000306
let gl_one_minus_dst_color = 0x00000307
let gl_src_alpha_saturate = 0x00000308
let gl_true = 0x00000001
let gl_false = 0x00000000
let gl_clip_plane0 = 0x00003000
let gl_clip_plane1 = 0x00003001
let gl_clip_plane2 = 0x00003002
let gl_clip_plane3 = 0x00003003
let gl_clip_plane4 = 0x00003004
let gl_clip_plane5 = 0x00003005
let gl_byte = 0x00001400
let gl_unsigned_byte = 0x00001401
let gl_short = 0x00001402
let gl_unsigned_short = 0x00001403
let gl_int = 0x00001404
let gl_unsigned_int = 0x00001405
let gl_float = 0x00001406
let gl_2_bytes = 0x00001407
let gl_3_bytes = 0x00001408
let gl_4_bytes = 0x00001409
let gl_double = 0x0000140a
let gl_none = 0x00000000
let gl_front_left = 0x00000400
let gl_front_right = 0x00000401
let gl_back_left = 0x00000402
let gl_back_right = 0x00000403
let gl_front = 0x00000404
let gl_back = 0x00000405
let gl_left = 0x00000406
let gl_right = 0x00000407
let gl_front_and_back = 0x00000408
let gl_aux0 = 0x00000409
let gl_aux1 = 0x0000040a
let gl_aux2 = 0x0000040b
let gl_aux3 = 0x0000040c
let gl_no_error = 0x00000000
let gl_invalid_enum = 0x00000500
let gl_invalid_value = 0x00000501
let gl_invalid_operation = 0x00000502
let gl_stack_overflow = 0x00000503
let gl_stack_underflow = 0x00000504
let gl_out_of_memory = 0x00000505
let gl_2d = 0x00000600
let gl_3d = 0x00000601
let gl_3d_color = 0x00000602
let gl_3d_color_texture = 0x00000603
let gl_4d_color_texture = 0x00000604
let gl_pass_through_token = 0x00000700
let gl_point_token = 0x00000701
let gl_line_token = 0x00000702
let gl_polygon_token = 0x00000703
let gl_bitmap_token = 0x00000704
let gl_draw_pixel_token = 0x00000705
let gl_copy_pixel_token = 0x00000706
let gl_line_reset_token = 0x00000707
let gl_exp = 0x00000800
let gl_exp2 = 0x00000801
let gl_cw = 0x00000900
let gl_ccw = 0x00000901
let gl_coeff = 0x00000a00
let gl_order = 0x00000a01
let gl_domain = 0x00000a02
let gl_current_color = 0x00000b00
let gl_current_index = 0x00000b01
let gl_current_normal = 0x00000b02
let gl_current_texture_coords = 0x00000b03
let gl_current_raster_color = 0x00000b04
let gl_current_raster_index = 0x00000b05
let gl_current_raster_texture_coords = 0x00000b06
let gl_current_raster_position = 0x00000b07
let gl_current_raster_position_valid = 0x00000b08
let gl_current_raster_distance = 0x00000b09
let gl_point_smooth = 0x00000b10
let gl_point_size = 0x00000b11
let gl_point_size_range = 0x00000b12
let gl_point_size_granularity = 0x00000b13
let gl_line_smooth = 0x00000b20
let gl_line_width = 0x00000b21
let gl_line_width_range = 0x00000b22
let gl_line_width_granularity = 0x00000b23
let gl_line_stipple = 0x00000b24
let gl_line_stipple_pattern = 0x00000b25
let gl_line_stipple_repeat = 0x00000b26
let gl_list_mode = 0x00000b30
let gl_max_list_nesting = 0x00000b31
let gl_list_base = 0x00000b32
let gl_list_index = 0x00000b33
let gl_polygon_mode = 0x00000b40
let gl_polygon_smooth = 0x00000b41
let gl_polygon_stipple = 0x00000b42
let gl_edge_flag = 0x00000b43
let gl_cull_face = 0x00000b44
let gl_cull_face_mode = 0x00000b45
let gl_front_face = 0x00000b46
let gl_lighting = 0x00000b50
let gl_light_model_local_viewer = 0x00000b51
let gl_light_model_two_side = 0x00000b52
let gl_light_model_ambient = 0x00000b53
let gl_shade_model = 0x00000b54
let gl_color_material_face = 0x00000b55
let gl_color_material_parameter = 0x00000b56
let gl_color_material = 0x00000b57
let gl_fog = 0x00000b60
let gl_fog_index = 0x00000b61
let gl_fog_density = 0x00000b62
let gl_fog_start = 0x00000b63
let gl_fog_end = 0x00000b64
let gl_fog_mode = 0x00000b65
let gl_fog_color = 0x00000b66
let gl_depth_range = 0x00000b70
let gl_depth_test = 0x00000b71
let gl_depth_writemask = 0x00000b72
let gl_depth_clear_value = 0x00000b73
let gl_depth_func = 0x00000b74
let gl_accum_clear_value = 0x00000b80
let gl_stencil_test = 0x00000b90
let gl_stencil_clear_value = 0x00000b91
let gl_stencil_func = 0x00000b92
let gl_stencil_value_mask = 0x00000b93
let gl_stencil_fail = 0x00000b94
let gl_stencil_pass_depth_fail = 0x00000b95
let gl_stencil_pass_depth_pass = 0x00000b96
let gl_stencil_ref = 0x00000b97
let gl_stencil_writemask = 0x00000b98
let gl_matrix_mode = 0x00000ba0
let gl_normalize = 0x00000ba1
let gl_viewport = 0x00000ba2
let gl_modelview_stack_depth = 0x00000ba3
let gl_projection_stack_depth = 0x00000ba4
let gl_texture_stack_depth = 0x00000ba5
let gl_modelview_matrix = 0x00000ba6
let gl_projection_matrix = 0x00000ba7
let gl_texture_matrix = 0x00000ba8
let gl_attrib_stack_depth = 0x00000bb0
let gl_client_attrib_stack_depth = 0x00000bb1
let gl_alpha_test = 0x00000bc0
let gl_alpha_test_func = 0x00000bc1
let gl_alpha_test_ref = 0x00000bc2
let gl_dither = 0x00000bd0
let gl_blend_dst = 0x00000be0
let gl_blend_src = 0x00000be1
let gl_blend = 0x00000be2
let gl_logic_op_mode = 0x00000bf0
let gl_index_logic_op = 0x00000bf1
let gl_color_logic_op = 0x00000bf2
let gl_aux_buffers = 0x00000c00
let gl_draw_buffer = 0x00000c01
let gl_read_buffer = 0x00000c02
let gl_scissor_box = 0x00000c10
let gl_scissor_test = 0x00000c11
let gl_index_clear_value = 0x00000c20
let gl_index_writemask = 0x00000c21
let gl_color_clear_value = 0x00000c22
let gl_color_writemask = 0x00000c23
let gl_index_mode = 0x00000c30
let gl_rgba_mode = 0x00000c31
let gl_doublebuffer = 0x00000c32
let gl_stereo = 0x00000c33
let gl_render_mode = 0x00000c40
let gl_perspective_correction_hint = 0x00000c50
let gl_point_smooth_hint = 0x00000c51
let gl_line_smooth_hint = 0x00000c52
let gl_polygon_smooth_hint = 0x00000c53
let gl_fog_hint = 0x00000c54
let gl_texture_gen_s = 0x00000c60
let gl_texture_gen_t = 0x00000c61
let gl_texture_gen_r = 0x00000c62
let gl_texture_gen_q = 0x00000c63
let gl_pixel_map_i_to_i = 0x00000c70
let gl_pixel_map_s_to_s = 0x00000c71
let gl_pixel_map_i_to_r = 0x00000c72
let gl_pixel_map_i_to_g = 0x00000c73
let gl_pixel_map_i_to_b = 0x00000c74
let gl_pixel_map_i_to_a = 0x00000c75
let gl_pixel_map_r_to_r = 0x00000c76
let gl_pixel_map_g_to_g = 0x00000c77
let gl_pixel_map_b_to_b = 0x00000c78
let gl_pixel_map_a_to_a = 0x00000c79
let gl_pixel_map_i_to_i_size = 0x00000cb0
let gl_pixel_map_s_to_s_size = 0x00000cb1
let gl_pixel_map_i_to_r_size = 0x00000cb2
let gl_pixel_map_i_to_g_size = 0x00000cb3
let gl_pixel_map_i_to_b_size = 0x00000cb4
let gl_pixel_map_i_to_a_size = 0x00000cb5
let gl_pixel_map_r_to_r_size = 0x00000cb6
let gl_pixel_map_g_to_g_size = 0x00000cb7
let gl_pixel_map_b_to_b_size = 0x00000cb8
let gl_pixel_map_a_to_a_size = 0x00000cb9
let gl_unpack_swap_bytes = 0x00000cf0
let gl_unpack_lsb_first = 0x00000cf1
let gl_unpack_row_length = 0x00000cf2
let gl_unpack_skip_rows = 0x00000cf3
let gl_unpack_skip_pixels = 0x00000cf4
let gl_unpack_alignment = 0x00000cf5
let gl_pack_swap_bytes = 0x00000d00
let gl_pack_lsb_first = 0x00000d01
let gl_pack_row_length = 0x00000d02
let gl_pack_skip_rows = 0x00000d03
let gl_pack_skip_pixels = 0x00000d04
let gl_pack_alignment = 0x00000d05
let gl_map_color = 0x00000d10
let gl_map_stencil = 0x00000d11
let gl_index_shift = 0x00000d12
let gl_index_offset = 0x00000d13
let gl_red_scale = 0x00000d14
let gl_red_bias = 0x00000d15
let gl_zoom_x = 0x00000d16
let gl_zoom_y = 0x00000d17
let gl_green_scale = 0x00000d18
let gl_green_bias = 0x00000d19
let gl_blue_scale = 0x00000d1a
let gl_blue_bias = 0x00000d1b
let gl_alpha_scale = 0x00000d1c
let gl_alpha_bias = 0x00000d1d
let gl_depth_scale = 0x00000d1e
let gl_depth_bias = 0x00000d1f
let gl_max_eval_order = 0x00000d30
let gl_max_lights = 0x00000d31
let gl_max_clip_planes = 0x00000d32
let gl_max_texture_size = 0x00000d33
let gl_max_pixel_map_table = 0x00000d34
let gl_max_attrib_stack_depth = 0x00000d35
let gl_max_modelview_stack_depth = 0x00000d36
let gl_max_name_stack_depth = 0x00000d37
let gl_max_projection_stack_depth = 0x00000d38
let gl_max_texture_stack_depth = 0x00000d39
let gl_max_viewport_dims = 0x00000d3a
let gl_max_client_attrib_stack_depth = 0x00000d3b
let gl_subpixel_bits = 0x00000d50
let gl_index_bits = 0x00000d51
let gl_red_bits = 0x00000d52
let gl_green_bits = 0x00000d53
let gl_blue_bits = 0x00000d54
let gl_alpha_bits = 0x00000d55
let gl_depth_bits = 0x00000d56
let gl_stencil_bits = 0x00000d57
let gl_accum_red_bits = 0x00000d58
let gl_accum_green_bits = 0x00000d59
let gl_accum_blue_bits = 0x00000d5a
let gl_accum_alpha_bits = 0x00000d5b
let gl_name_stack_depth = 0x00000d70
let gl_auto_normal = 0x00000d80
let gl_map1_color_4 = 0x00000d90
let gl_map1_index = 0x00000d91
let gl_map1_normal = 0x00000d92
let gl_map1_texture_coord_1 = 0x00000d93
let gl_map1_texture_coord_2 = 0x00000d94
let gl_map1_texture_coord_3 = 0x00000d95
let gl_map1_texture_coord_4 = 0x00000d96
let gl_map1_vertex_3 = 0x00000d97
let gl_map1_vertex_4 = 0x00000d98
let gl_map2_color_4 = 0x00000db0
let gl_map2_index = 0x00000db1
let gl_map2_normal = 0x00000db2
let gl_map2_texture_coord_1 = 0x00000db3
let gl_map2_texture_coord_2 = 0x00000db4
let gl_map2_texture_coord_3 = 0x00000db5
let gl_map2_texture_coord_4 = 0x00000db6
let gl_map2_vertex_3 = 0x00000db7
let gl_map2_vertex_4 = 0x00000db8
let gl_map1_grid_domain = 0x00000dd0
let gl_map1_grid_segments = 0x00000dd1
let gl_map2_grid_domain = 0x00000dd2
let gl_map2_grid_segments = 0x00000dd3
let gl_texture_1d = 0x00000de0
let gl_texture_2d = 0x00000de1
let gl_feedback_buffer_pointer = 0x00000df0
let gl_feedback_buffer_size = 0x00000df1
let gl_feedback_buffer_type = 0x00000df2
let gl_selection_buffer_pointer = 0x00000df3
let gl_selection_buffer_size = 0x00000df4
let gl_texture_width = 0x00001000
let gl_texture_height = 0x00001001
let gl_texture_internal_format = 0x00001003
let gl_texture_border_color = 0x00001004
let gl_texture_border = 0x00001005
let gl_dont_care = 0x00001100
let gl_fastest = 0x00001101
let gl_nicest = 0x00001102
let gl_light0 = 0x00004000
let gl_light1 = 0x00004001
let gl_light2 = 0x00004002
let gl_light3 = 0x00004003
let gl_light4 = 0x00004004
let gl_light5 = 0x00004005
let gl_light6 = 0x00004006
let gl_light7 = 0x00004007
let gl_ambient = 0x00001200
let gl_diffuse = 0x00001201
let gl_specular = 0x00001202
let gl_position = 0x00001203
let gl_spot_direction = 0x00001204
let gl_spot_exponent = 0x00001205
let gl_spot_cutoff = 0x00001206
let gl_constant_attenuation = 0x00001207
let gl_linear_attenuation = 0x00001208
let gl_quadratic_attenuation = 0x00001209
let gl_compile = 0x00001300
let gl_compile_and_execute = 0x00001301
let gl_clear = 0x00001500
let gl_and = 0x00001501
let gl_and_reverse = 0x00001502
let gl_copy = 0x00001503
let gl_and_inverted = 0x00001504
let gl_noop = 0x00001505
let gl_xor = 0x00001506
let gl_or = 0x00001507
let gl_nor = 0x00001508
let gl_equiv = 0x00001509
let gl_invert = 0x0000150a
let gl_or_reverse = 0x0000150b
let gl_copy_inverted = 0x0000150c
let gl_or_inverted = 0x0000150d
let gl_nand = 0x0000150e
let gl_set = 0x0000150f
let gl_emission = 0x00001600
let gl_shininess = 0x00001601
let gl_ambient_and_diffuse = 0x00001602
let gl_color_indexes = 0x00001603
let gl_modelview = 0x00001700
let gl_projection = 0x00001701
let gl_texture = 0x00001702
let gl_color = 0x00001800
let gl_depth = 0x00001801
let gl_stencil = 0x00001802
let gl_color_index = 0x00001900
let gl_stencil_index = 0x00001901
let gl_depth_component = 0x00001902
let gl_red = 0x00001903
let gl_green = 0x00001904
let gl_blue = 0x00001905
let gl_alpha = 0x00001906
let gl_rgb = 0x00001907
let gl_rgba = 0x00001908
let gl_luminance = 0x00001909
let gl_luminance_alpha = 0x0000190a
let gl_bitmap = 0x00001a00
let gl_point = 0x00001b00
let gl_line = 0x00001b01
let gl_fill = 0x00001b02
let gl_render = 0x00001c00
let gl_feedback = 0x00001c01
let gl_select = 0x00001c02
let gl_flat = 0x00001d00
let gl_smooth = 0x00001d01
let gl_keep = 0x00001e00
let gl_replace = 0x00001e01
let gl_incr = 0x00001e02
let gl_decr = 0x00001e03
let gl_vendor = 0x00001f00
let gl_renderer = 0x00001f01
let gl_version = 0x00001f02
let gl_extensions = 0x00001f03
let gl_s = 0x00002000
let gl_t = 0x00002001
let gl_r = 0x00002002
let gl_q = 0x00002003
let gl_modulate = 0x00002100
let gl_decal = 0x00002101
let gl_texture_env_mode = 0x00002200
let gl_texture_env_color = 0x00002201
let gl_texture_env = 0x00002300
let gl_eye_linear = 0x00002400
let gl_object_linear = 0x00002401
let gl_sphere_map = 0x00002402
let gl_texture_gen_mode = 0x00002500
let gl_object_plane = 0x00002501
let gl_eye_plane = 0x00002502
let gl_nearest = 0x00002600
let gl_linear = 0x00002601
let gl_nearest_mipmap_nearest = 0x00002700
let gl_linear_mipmap_nearest = 0x00002701
let gl_nearest_mipmap_linear = 0x00002702
let gl_linear_mipmap_linear = 0x00002703
let gl_texture_mag_filter = 0x00002800
let gl_texture_min_filter = 0x00002801
let gl_texture_wrap_s = 0x00002802
let gl_texture_wrap_t = 0x00002803
let gl_clamp = 0x00002900
let gl_repeat = 0x00002901
let gl_client_pixel_store_bit = 0x00000001
let gl_client_vertex_array_bit = 0x00000002
let gl_client_all_attrib_bits = 0x7fffffff
let gl_polygon_offset_factor = 0x00008038
let gl_polygon_offset_units = 0x00002a00
let gl_polygon_offset_point = 0x00002a01
let gl_polygon_offset_line = 0x00002a02
let gl_polygon_offset_fill = 0x00008037
let gl_alpha4 = 0x0000803b
let gl_alpha8 = 0x0000803c
let gl_alpha12 = 0x0000803d
let gl_alpha16 = 0x0000803e
let gl_luminance4 = 0x0000803f
let gl_luminance8 = 0x00008040
let gl_luminance12 = 0x00008041
let gl_luminance16 = 0x00008042
let gl_luminance4_alpha4 = 0x00008043
let gl_luminance6_alpha2 = 0x00008044
let gl_luminance8_alpha8 = 0x00008045
let gl_luminance12_alpha4 = 0x00008046
let gl_luminance12_alpha12 = 0x00008047
let gl_luminance16_alpha16 = 0x00008048
let gl_intensity = 0x00008049
let gl_intensity4 = 0x0000804a
let gl_intensity8 = 0x0000804b
let gl_intensity12 = 0x0000804c
let gl_intensity16 = 0x0000804d
let gl_r3_g3_b2 = 0x00002a10
let gl_rgb4 = 0x0000804f
let gl_rgb5 = 0x00008050
let gl_rgb8 = 0x00008051
let gl_rgb10 = 0x00008052
let gl_rgb12 = 0x00008053
let gl_rgb16 = 0x00008054
let gl_rgba2 = 0x00008055
let gl_rgba4 = 0x00008056
let gl_rgb5_a1 = 0x00008057
let gl_rgba8 = 0x00008058
let gl_rgb10_a2 = 0x00008059
let gl_rgba12 = 0x0000805a
let gl_rgba16 = 0x0000805b
let gl_texture_red_size = 0x0000805c
let gl_texture_green_size = 0x0000805d
let gl_texture_blue_size = 0x0000805e
let gl_texture_alpha_size = 0x0000805f
let gl_texture_luminance_size = 0x00008060
let gl_texture_intensity_size = 0x00008061
let gl_proxy_texture_1d = 0x00008063
let gl_proxy_texture_2d = 0x00008064
let gl_texture_priority = 0x00008066
let gl_texture_resident = 0x00008067
let gl_texture_binding_1d = 0x00008068
let gl_texture_binding_2d = 0x00008069
let gl_vertex_array = 0x00008074
let gl_normal_array = 0x00008075
let gl_color_array = 0x00008076
let gl_index_array = 0x00008077
let gl_texture_coord_array = 0x00008078
let gl_edge_flag_array = 0x00008079
let gl_vertex_array_size = 0x0000807a
let gl_vertex_array_type = 0x0000807b
let gl_vertex_array_stride = 0x0000807c
let gl_normal_array_type = 0x0000807e
let gl_normal_array_stride = 0x0000807f
let gl_color_array_size = 0x00008081
let gl_color_array_type = 0x00008082
let gl_color_array_stride = 0x00008083
let gl_index_array_type = 0x00008085
let gl_index_array_stride = 0x00008086
let gl_texture_coord_array_size = 0x00008088
let gl_texture_coord_array_type = 0x00008089
let gl_texture_coord_array_stride = 0x0000808a
let gl_edge_flag_array_stride = 0x0000808c
let gl_vertex_array_pointer = 0x0000808e
let gl_normal_array_pointer = 0x0000808f
let gl_color_array_pointer = 0x00008090
let gl_index_array_pointer = 0x00008091
let gl_texture_coord_array_pointer = 0x00008092
let gl_edge_flag_array_pointer = 0x00008093
let gl_v2f = 0x00002a20
let gl_v3f = 0x00002a21
let gl_c4ub_v2f = 0x00002a22
let gl_c4ub_v3f = 0x00002a23
let gl_c3f_v3f = 0x00002a24
let gl_n3f_v3f = 0x00002a25
let gl_c4f_n3f_v3f = 0x00002a26
let gl_t2f_v3f = 0x00002a27
let gl_t4f_v4f = 0x00002a28
let gl_t2f_c4ub_v3f = 0x00002a29
let gl_t2f_c3f_v3f = 0x00002a2a
let gl_t2f_n3f_v3f = 0x00002a2b
let gl_t2f_c4f_n3f_v3f = 0x00002a2c
let gl_t4f_c4f_n3f_v4f = 0x00002a2d
let gl_logic_op = 0x00000bf1
let gl_texture_components = 0x00001003
let gl_color_index1_ext = 0x000080e2
let gl_color_index2_ext = 0x000080e3
let gl_color_index4_ext = 0x000080e4
let gl_color_index8_ext = 0x000080e5
let gl_color_index12_ext = 0x000080e6
let gl_color_index16_ext = 0x000080e7
let gl_unsigned_byte_3_3_2 = 0x00008032
let gl_unsigned_short_4_4_4_4 = 0x00008033
let gl_unsigned_short_5_5_5_1 = 0x00008034
let gl_unsigned_int_8_8_8_8 = 0x00008035
let gl_unsigned_int_10_10_10_2 = 0x00008036
let gl_rescale_normal = 0x0000803a
let gl_unsigned_byte_2_3_3_rev = 0x00008362
let gl_unsigned_short_5_6_5 = 0x00008363
let gl_unsigned_short_5_6_5_rev = 0x00008364
let gl_unsigned_short_4_4_4_4_rev = 0x00008365
let gl_unsigned_short_1_5_5_5_rev = 0x00008366
let gl_unsigned_int_8_8_8_8_rev = 0x00008367
let gl_unsigned_int_2_10_10_10_rev = 0x00008368
let gl_bgr = 0x000080e0
let gl_bgra = 0x000080e1
let gl_max_elements_vertices = 0x000080e8
let gl_max_elements_indices = 0x000080e9
let gl_clamp_to_edge = 0x0000812f
let gl_texture_min_lod = 0x0000813a
let gl_texture_max_lod = 0x0000813b
let gl_texture_base_level = 0x0000813c
let gl_texture_max_level = 0x0000813d
let gl_light_model_color_control = 0x000081f8
let gl_single_color = 0x000081f9
let gl_separate_specular_color = 0x000081fa
let gl_smooth_point_size_range = 0x00000b12
let gl_smooth_point_size_granularity = 0x00000b13
let gl_smooth_line_width_range = 0x00000b22
let gl_smooth_line_width_granularity = 0x00000b23
let gl_aliased_point_size_range = 0x0000846d
let gl_aliased_line_width_range = 0x0000846e
let gl_pack_skip_images = 0x0000806b
let gl_pack_image_height = 0x0000806c
let gl_unpack_skip_images = 0x0000806d
let gl_unpack_image_height = 0x0000806e
let gl_texture_3d = 0x0000806f
let gl_proxy_texture_3d = 0x00008070
let gl_texture_depth = 0x00008071
let gl_texture_wrap_r = 0x00008072
let gl_max_3d_texture_size = 0x00008073
let gl_texture_binding_3d = 0x0000806a
let gl_texture0 = 0x000084c0
let gl_texture1 = 0x000084c1
let gl_texture2 = 0x000084c2
let gl_texture3 = 0x000084c3
let gl_texture4 = 0x000084c4
let gl_texture5 = 0x000084c5
let gl_texture6 = 0x000084c6
let gl_texture7 = 0x000084c7
let gl_texture8 = 0x000084c8
let gl_texture9 = 0x000084c9
let gl_texture10 = 0x000084ca
let gl_texture11 = 0x000084cb
let gl_texture12 = 0x000084cc
let gl_texture13 = 0x000084cd
let gl_texture14 = 0x000084ce
let gl_texture15 = 0x000084cf
let gl_texture16 = 0x000084d0
let gl_texture17 = 0x000084d1
let gl_texture18 = 0x000084d2
let gl_texture19 = 0x000084d3
let gl_texture20 = 0x000084d4
let gl_texture21 = 0x000084d5
let gl_texture22 = 0x000084d6
let gl_texture23 = 0x000084d7
let gl_texture24 = 0x000084d8
let gl_texture25 = 0x000084d9
let gl_texture26 = 0x000084da
let gl_texture27 = 0x000084db
let gl_texture28 = 0x000084dc
let gl_texture29 = 0x000084dd
let gl_texture30 = 0x000084de
let gl_texture31 = 0x000084df
let gl_active_texture = 0x000084e0
let gl_client_active_texture = 0x000084e1
let gl_max_texture_units = 0x000084e2
let gl_normal_map = 0x00008511
let gl_reflection_map = 0x00008512
let gl_texture_cube_map = 0x00008513
let gl_texture_binding_cube_map = 0x00008514
let gl_texture_cube_map_positive_x = 0x00008515
let gl_texture_cube_map_negative_x = 0x00008516
let gl_texture_cube_map_positive_y = 0x00008517
let gl_texture_cube_map_negative_y = 0x00008518
let gl_texture_cube_map_positive_z = 0x00008519
let gl_texture_cube_map_negative_z = 0x0000851a
let gl_proxy_texture_cube_map = 0x0000851b
let gl_max_cube_map_texture_size = 0x0000851c
let gl_compressed_alpha = 0x000084e9
let gl_compressed_luminance = 0x000084ea
let gl_compressed_luminance_alpha = 0x000084eb
let gl_compressed_intensity = 0x000084ec
let gl_compressed_rgb = 0x000084ed
let gl_compressed_rgba = 0x000084ee
let gl_texture_compression_hint = 0x000084ef
let gl_texture_compressed_image_size = 0x000086a0
let gl_texture_compressed = 0x000086a1
let gl_num_compressed_texture_formats = 0x000086a2
let gl_compressed_texture_formats = 0x000086a3
let gl_multisample = 0x0000809d
let gl_sample_alpha_to_coverage = 0x0000809e
let gl_sample_alpha_to_one = 0x0000809f
let gl_sample_coverage = 0x000080a0
let gl_sample_buffers = 0x000080a8
let gl_samples = 0x000080a9
let gl_sample_coverage_value = 0x000080aa
let gl_sample_coverage_invert = 0x000080ab
let gl_multisample_bit = 0x20000000
let gl_transpose_modelview_matrix = 0x000084e3
let gl_transpose_projection_matrix = 0x000084e4
let gl_transpose_texture_matrix = 0x000084e5
let gl_transpose_color_matrix = 0x000084e6
let gl_combine = 0x00008570
let gl_combine_rgb = 0x00008571
let gl_combine_alpha = 0x00008572
let gl_source0_rgb = 0x00008580
let gl_source1_rgb = 0x00008581
let gl_source2_rgb = 0x00008582
let gl_source0_alpha = 0x00008588
let gl_source1_alpha = 0x00008589
let gl_source2_alpha = 0x0000858a
let gl_operand0_rgb = 0x00008590
let gl_operand1_rgb = 0x00008591
let gl_operand2_rgb = 0x00008592
let gl_operand0_alpha = 0x00008598
let gl_operand1_alpha = 0x00008599
let gl_operand2_alpha = 0x0000859a
let gl_rgb_scale = 0x00008573
let gl_add_signed = 0x00008574
let gl_interpolate = 0x00008575
let gl_subtract = 0x000084e7
let gl_constant = 0x00008576
let gl_primary_color = 0x00008577
let gl_previous = 0x00008578
let gl_dot3_rgb = 0x000086ae
let gl_dot3_rgba = 0x000086af
let gl_clamp_to_border = 0x0000812d
let gl_generate_mipmap = 0x00008191
let gl_generate_mipmap_hint = 0x00008192
let gl_depth_component16 = 0x000081a5
let gl_depth_component24 = 0x000081a6
let gl_depth_component32 = 0x000081a7
let gl_texture_depth_size = 0x0000884a
let gl_depth_texture_mode = 0x0000884b
let gl_texture_compare_mode = 0x0000884c
let gl_texture_compare_func = 0x0000884d
let gl_compare_r_to_texture = 0x0000884e
let gl_fog_coordinate_source = 0x00008450
let gl_fog_coordinate = 0x00008451
let gl_fragment_depth = 0x00008452
let gl_current_fog_coordinate = 0x00008453
let gl_fog_coordinate_array_type = 0x00008454
let gl_fog_coordinate_array_stride = 0x00008455
let gl_fog_coordinate_array_pointer = 0x00008456
let gl_fog_coordinate_array = 0x00008457
let gl_point_size_min = 0x00008126
let gl_point_size_max = 0x00008127
let gl_point_fade_threshold_size = 0x00008128
let gl_point_distance_attenuation = 0x00008129
let gl_color_sum = 0x00008458
let gl_current_secondary_color = 0x00008459
let gl_secondary_color_array_size = 0x0000845a
let gl_secondary_color_array_type = 0x0000845b
let gl_secondary_color_array_stride = 0x0000845c
let gl_secondary_color_array_pointer = 0x0000845d
let gl_secondary_color_array = 0x0000845e
let gl_blend_dst_rgb = 0x000080c8
let gl_blend_src_rgb = 0x000080c9
let gl_blend_dst_alpha = 0x000080ca
let gl_blend_src_alpha = 0x000080cb
let gl_incr_wrap = 0x00008507
let gl_decr_wrap = 0x00008508
let gl_texture_filter_control = 0x00008500
let gl_texture_lod_bias = 0x00008501
let gl_max_texture_lod_bias = 0x000084fd
let gl_mirrored_repeat = 0x00008370
let gl_buffer_size = 0x00008764
let gl_buffer_usage = 0x00008765
let gl_query_counter_bits = 0x00008864
let gl_current_query = 0x00008865
let gl_query_result = 0x00008866
let gl_query_result_available = 0x00008867
let gl_array_buffer = 0x00008892
let gl_element_array_buffer = 0x00008893
let gl_array_buffer_binding = 0x00008894
let gl_element_array_buffer_binding = 0x00008895
let gl_vertex_array_buffer_binding = 0x00008896
let gl_normal_array_buffer_binding = 0x00008897
let gl_color_array_buffer_binding = 0x00008898
let gl_index_array_buffer_binding = 0x00008899
let gl_texture_coord_array_buffer_binding = 0x0000889a
let gl_edge_flag_array_buffer_binding = 0x0000889b
let gl_secondary_color_array_buffer_binding = 0x0000889c
let gl_fog_coordinate_array_buffer_binding = 0x0000889d
let gl_weight_array_buffer_binding = 0x0000889e
let gl_vertex_attrib_array_buffer_binding = 0x0000889f
let gl_read_only = 0x000088b8
let gl_write_only = 0x000088b9
let gl_read_write = 0x000088ba
let gl_buffer_access = 0x000088bb
let gl_buffer_mapped = 0x000088bc
let gl_buffer_map_pointer = 0x000088bd
let gl_stream_draw = 0x000088e0
let gl_stream_read = 0x000088e1
let gl_stream_copy = 0x000088e2
let gl_static_draw = 0x000088e4
let gl_static_read = 0x000088e5
let gl_static_copy = 0x000088e6
let gl_dynamic_draw = 0x000088e8
let gl_dynamic_read = 0x000088e9
let gl_dynamic_copy = 0x000088ea
let gl_samples_passed = 0x00008914
let gl_fog_coord_src = gl_fog_coordinate_source
let gl_fog_coord = gl_fog_coordinate
let gl_current_fog_coord = gl_current_fog_coordinate
let gl_fog_coord_array_type = gl_fog_coordinate_array_type
let gl_fog_coord_array_stride = gl_fog_coordinate_array_stride
let gl_fog_coord_array_pointer = gl_fog_coordinate_array_pointer
let gl_fog_coord_array = gl_fog_coordinate_array
let gl_fog_coord_array_buffer_binding = gl_fog_coordinate_array_buffer_binding
let gl_src0_rgb = gl_source0_rgb
let gl_src1_rgb = gl_source1_rgb
let gl_src2_rgb = gl_source2_rgb
let gl_src0_alpha = gl_source0_alpha
let gl_src1_alpha = gl_source1_alpha
let gl_src2_alpha = gl_source2_alpha
let gl_blend_equation_rgb = gl_blend_equation
let gl_vertex_attrib_array_enabled = 0x00008622
let gl_vertex_attrib_array_size = 0x00008623
let gl_vertex_attrib_array_stride = 0x00008624
let gl_vertex_attrib_array_type = 0x00008625
let gl_current_vertex_attrib = 0x00008626
let gl_vertex_program_point_size = 0x00008642
let gl_vertex_program_two_side = 0x00008643
let gl_vertex_attrib_array_pointer = 0x00008645
let gl_stencil_back_func = 0x00008800
let gl_stencil_back_fail = 0x00008801
let gl_stencil_back_pass_depth_fail = 0x00008802
let gl_stencil_back_pass_depth_pass = 0x00008803
let gl_max_draw_buffers = 0x00008824
let gl_draw_buffer0 = 0x00008825
let gl_draw_buffer1 = 0x00008826
let gl_draw_buffer2 = 0x00008827
let gl_draw_buffer3 = 0x00008828
let gl_draw_buffer4 = 0x00008829
let gl_draw_buffer5 = 0x0000882a
let gl_draw_buffer6 = 0x0000882b
let gl_draw_buffer7 = 0x0000882c
let gl_draw_buffer8 = 0x0000882d
let gl_draw_buffer9 = 0x0000882e
let gl_draw_buffer10 = 0x0000882f
let gl_draw_buffer11 = 0x00008830
let gl_draw_buffer12 = 0x00008831
let gl_draw_buffer13 = 0x00008832
let gl_draw_buffer14 = 0x00008833
let gl_draw_buffer15 = 0x00008834
let gl_blend_equation_alpha = 0x0000883d
let gl_point_sprite = 0x00008861
let gl_coord_replace = 0x00008862
let gl_max_vertex_attribs = 0x00008869
let gl_vertex_attrib_array_normalized = 0x0000886a
let gl_max_texture_coords = 0x00008871
let gl_max_texture_image_units = 0x00008872
let gl_fragment_shader = 0x00008b30
let gl_vertex_shader = 0x00008b31
let gl_max_fragment_uniform_components = 0x00008b49
let gl_max_vertex_uniform_components = 0x00008b4a
let gl_max_varying_floats = 0x00008b4b
let gl_max_vertex_texture_image_units = 0x00008b4c
let gl_max_combined_texture_image_units = 0x00008b4d
let gl_shader_type = 0x00008b4f
let gl_float_vec2 = 0x00008b50
let gl_float_vec3 = 0x00008b51
let gl_float_vec4 = 0x00008b52
let gl_int_vec2 = 0x00008b53
let gl_int_vec3 = 0x00008b54
let gl_int_vec4 = 0x00008b55
let gl_bool = 0x00008b56
let gl_bool_vec2 = 0x00008b57
let gl_bool_vec3 = 0x00008b58
let gl_bool_vec4 = 0x00008b59
let gl_float_mat2 = 0x00008b5a
let gl_float_mat3 = 0x00008b5b
let gl_float_mat4 = 0x00008b5c
let gl_sampler_1d = 0x00008b5d
let gl_sampler_2d = 0x00008b5e
let gl_sampler_3d = 0x00008b5f
let gl_sampler_cube = 0x00008b60
let gl_sampler_1d_shadow = 0x00008b61
let gl_sampler_2d_shadow = 0x00008b62
let gl_delete_status = 0x00008b80
let gl_compile_status = 0x00008b81
let gl_link_status = 0x00008b82
let gl_validate_status = 0x00008b83
let gl_info_log_length = 0x00008b84
let gl_attached_shaders = 0x00008b85
let gl_active_uniforms = 0x00008b86
let gl_active_uniform_max_length = 0x00008b87
let gl_shader_source_length = 0x00008b88
let gl_active_attributes = 0x00008b89
let gl_active_attribute_max_length = 0x00008b8a
let gl_fragment_shader_derivative_hint = 0x00008b8b
let gl_shading_language_version = 0x00008b8c
let gl_current_program = 0x00008b8d
let gl_point_sprite_coord_origin = 0x00008ca0
let gl_lower_left = 0x00008ca1
let gl_upper_left = 0x00008ca2
let gl_stencil_back_ref = 0x00008ca3
let gl_stencil_back_value_mask = 0x00008ca4
let gl_stencil_back_writemask = 0x00008ca5
let gl_current_raster_secondary_color = 0x0000845f
let gl_pixel_pack_buffer = 0x000088eb
let gl_pixel_unpack_buffer = 0x000088ec
let gl_pixel_pack_buffer_binding = 0x000088ed
let gl_pixel_unpack_buffer_binding = 0x000088ef
let gl_srgb = 0x00008c40
let gl_srgb8 = 0x00008c41
let gl_srgb_alpha = 0x00008c42
let gl_srgb8_alpha8 = 0x00008c43
let gl_sluminance_alpha = 0x00008c44
let gl_sluminance8_alpha8 = 0x00008c45
let gl_sluminance = 0x00008c46
let gl_sluminance8 = 0x00008c47
let gl_compressed_srgb = 0x00008c48
let gl_compressed_srgb_alpha = 0x00008c49
let gl_compressed_sluminance = 0x00008c4a
let gl_compressed_sluminance_alpha = 0x00008c4b
external glAccum: int -> float -> unit = "glstub_glAccum" "glstub_glAccum"
external glActiveStencilFaceEXT: int -> unit = "glstub_glActiveStencilFaceEXT" "glstub_glActiveStencilFaceEXT"
external glActiveTexture: int -> unit = "glstub_glActiveTexture" "glstub_glActiveTexture"
external glActiveTextureARB: int -> unit = "glstub_glActiveTextureARB" "glstub_glActiveTextureARB"
external glActiveVaryingNV: int -> string -> unit = "glstub_glActiveVaryingNV" "glstub_glActiveVaryingNV"
external glAddSwapHintRectWIN: int -> int -> int -> int -> unit = "glstub_glAddSwapHintRectWIN" "glstub_glAddSwapHintRectWIN"
external glAlphaFragmentOp1ATI: int -> int -> int -> int -> int -> int -> unit = "glstub_glAlphaFragmentOp1ATI_byte" "glstub_glAlphaFragmentOp1ATI"
external glAlphaFragmentOp2ATI: int -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glAlphaFragmentOp2ATI_byte" "glstub_glAlphaFragmentOp2ATI"
external glAlphaFragmentOp3ATI: int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glAlphaFragmentOp3ATI_byte" "glstub_glAlphaFragmentOp3ATI"
external glAlphaFunc: int -> float -> unit = "glstub_glAlphaFunc" "glstub_glAlphaFunc"
external glApplyTextureEXT: int -> unit = "glstub_glApplyTextureEXT" "glstub_glApplyTextureEXT"

external glAreProgramsResidentNV: int -> word_array -> word_array -> bool = "glstub_glAreProgramsResidentNV" "glstub_glAreProgramsResidentNV"
let glAreProgramsResidentNV p0 p1 p2 =
let np1 = to_word_array p1 in
let np2 = to_word_array (bool_to_int_array p2) in
let r = glAreProgramsResidentNV p0 np1 np2 in
let _ = copy_word_array np1 p1 in
let bp2 =  Array.create (Bigarray.Array1.dim np2) 0 in
let _ = copy_word_array np2 bp2 in
let _ = copy_to_bool_array bp2 p2 in
r


external glAreTexturesResident: int -> word_array -> word_array -> bool = "glstub_glAreTexturesResident" "glstub_glAreTexturesResident"
let glAreTexturesResident p0 p1 p2 =
let np1 = to_word_array p1 in
let np2 = to_word_array (bool_to_int_array p2) in
let r = glAreTexturesResident p0 np1 np2 in
let bp2 =  Array.create (Bigarray.Array1.dim np2) 0 in
let _ = copy_word_array np2 bp2 in
let _ = copy_to_bool_array bp2 p2 in
r


external glAreTexturesResidentEXT: int -> word_array -> word_array -> bool = "glstub_glAreTexturesResidentEXT" "glstub_glAreTexturesResidentEXT"
let glAreTexturesResidentEXT p0 p1 p2 =
let np1 = to_word_array p1 in
let np2 = to_word_array (bool_to_int_array p2) in
let r = glAreTexturesResidentEXT p0 np1 np2 in
let _ = copy_word_array np1 p1 in
let bp2 =  Array.create (Bigarray.Array1.dim np2) 0 in
let _ = copy_word_array np2 bp2 in
let _ = copy_to_bool_array bp2 p2 in
r

external glArrayElement: int -> unit = "glstub_glArrayElement" "glstub_glArrayElement"
external glArrayElementEXT: int -> unit = "glstub_glArrayElementEXT" "glstub_glArrayElementEXT"
external glArrayObjectATI: int -> int -> int -> int -> int -> int -> unit = "glstub_glArrayObjectATI_byte" "glstub_glArrayObjectATI"
external glAsyncMarkerSGIX: int -> unit = "glstub_glAsyncMarkerSGIX" "glstub_glAsyncMarkerSGIX"
external glAttachObjectARB: int -> int -> unit = "glstub_glAttachObjectARB" "glstub_glAttachObjectARB"
external glAttachShader: int -> int -> unit = "glstub_glAttachShader" "glstub_glAttachShader"
external glBegin: int -> unit = "glstub_glBegin" "glstub_glBegin"
external glBeginFragmentShaderATI: unit -> unit = "glstub_glBeginFragmentShaderATI" "glstub_glBeginFragmentShaderATI"
external glBeginOcclusionQueryNV: int -> unit = "glstub_glBeginOcclusionQueryNV" "glstub_glBeginOcclusionQueryNV"
external glBeginQuery: int -> int -> unit = "glstub_glBeginQuery" "glstub_glBeginQuery"
external glBeginQueryARB: int -> int -> unit = "glstub_glBeginQueryARB" "glstub_glBeginQueryARB"
external glBeginSceneEXT: unit -> unit = "glstub_glBeginSceneEXT" "glstub_glBeginSceneEXT"
external glBeginTransformFeedbackNV: int -> unit = "glstub_glBeginTransformFeedbackNV" "glstub_glBeginTransformFeedbackNV"
external glBeginVertexShaderEXT: unit -> unit = "glstub_glBeginVertexShaderEXT" "glstub_glBeginVertexShaderEXT"
external glBindAttribLocation: int -> int -> string -> unit = "glstub_glBindAttribLocation" "glstub_glBindAttribLocation"
external glBindAttribLocationARB: int -> int -> string -> unit = "glstub_glBindAttribLocationARB" "glstub_glBindAttribLocationARB"
external glBindBuffer: int -> int -> unit = "glstub_glBindBuffer" "glstub_glBindBuffer"
external glBindBufferARB: int -> int -> unit = "glstub_glBindBufferARB" "glstub_glBindBufferARB"
external glBindBufferBaseNV: int -> int -> int -> unit = "glstub_glBindBufferBaseNV" "glstub_glBindBufferBaseNV"
external glBindBufferOffsetNV: int -> int -> int -> int -> unit = "glstub_glBindBufferOffsetNV" "glstub_glBindBufferOffsetNV"
external glBindBufferRangeNV: int -> int -> int -> int -> int -> unit = "glstub_glBindBufferRangeNV" "glstub_glBindBufferRangeNV"
external glBindFragDataLocationEXT: int -> int -> string -> unit = "glstub_glBindFragDataLocationEXT" "glstub_glBindFragDataLocationEXT"
external glBindFragmentShaderATI: int -> unit = "glstub_glBindFragmentShaderATI" "glstub_glBindFragmentShaderATI"
external glBindFramebufferEXT: int -> int -> unit = "glstub_glBindFramebufferEXT" "glstub_glBindFramebufferEXT"
external glBindLightParameterEXT: int -> int -> int = "glstub_glBindLightParameterEXT" "glstub_glBindLightParameterEXT"
external glBindMaterialParameterEXT: int -> int -> int = "glstub_glBindMaterialParameterEXT" "glstub_glBindMaterialParameterEXT"
external glBindParameterEXT: int -> int = "glstub_glBindParameterEXT" "glstub_glBindParameterEXT"
external glBindProgramARB: int -> int -> unit = "glstub_glBindProgramARB" "glstub_glBindProgramARB"
external glBindProgramNV: int -> int -> unit = "glstub_glBindProgramNV" "glstub_glBindProgramNV"
external glBindRenderbufferEXT: int -> int -> unit = "glstub_glBindRenderbufferEXT" "glstub_glBindRenderbufferEXT"
external glBindTexGenParameterEXT: int -> int -> int -> int = "glstub_glBindTexGenParameterEXT" "glstub_glBindTexGenParameterEXT"
external glBindTexture: int -> int -> unit = "glstub_glBindTexture" "glstub_glBindTexture"
external glBindTextureEXT: int -> int -> unit = "glstub_glBindTextureEXT" "glstub_glBindTextureEXT"
external glBindTextureUnitParameterEXT: int -> int -> int = "glstub_glBindTextureUnitParameterEXT" "glstub_glBindTextureUnitParameterEXT"
external glBindVertexArrayAPPLE: int -> unit = "glstub_glBindVertexArrayAPPLE" "glstub_glBindVertexArrayAPPLE"
external glBindVertexShaderEXT: int -> unit = "glstub_glBindVertexShaderEXT" "glstub_glBindVertexShaderEXT"
external glBinormalPointerEXT: int -> int -> 'a -> unit = "glstub_glBinormalPointerEXT" "glstub_glBinormalPointerEXT"

external glBitmap: int -> int -> float -> float -> float -> float -> ubyte_array -> unit = "glstub_glBitmap_byte" "glstub_glBitmap"
let glBitmap p0 p1 p2 p3 p4 p5 p6 =
let np6 = to_ubyte_array p6 in
let r = glBitmap p0 p1 p2 p3 p4 p5 np6 in
r

external glBlendColor: float -> float -> float -> float -> unit = "glstub_glBlendColor" "glstub_glBlendColor"
external glBlendColorEXT: float -> float -> float -> float -> unit = "glstub_glBlendColorEXT" "glstub_glBlendColorEXT"
external glBlendEquation: int -> unit = "glstub_glBlendEquation" "glstub_glBlendEquation"
external glBlendEquationEXT: int -> unit = "glstub_glBlendEquationEXT" "glstub_glBlendEquationEXT"
external glBlendEquationSeparate: int -> int -> unit = "glstub_glBlendEquationSeparate" "glstub_glBlendEquationSeparate"
external glBlendEquationSeparateEXT: int -> int -> unit = "glstub_glBlendEquationSeparateEXT" "glstub_glBlendEquationSeparateEXT"
external glBlendFunc: int -> int -> unit = "glstub_glBlendFunc" "glstub_glBlendFunc"
external glBlendFuncSeparate: int -> int -> int -> int -> unit = "glstub_glBlendFuncSeparate" "glstub_glBlendFuncSeparate"
external glBlendFuncSeparateEXT: int -> int -> int -> int -> unit = "glstub_glBlendFuncSeparateEXT" "glstub_glBlendFuncSeparateEXT"
external glBlitFramebufferEXT: int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glBlitFramebufferEXT_byte" "glstub_glBlitFramebufferEXT"
external glBufferData: int -> int -> 'a -> int -> unit = "glstub_glBufferData" "glstub_glBufferData"
external glBufferDataARB: int -> int -> 'a -> int -> unit = "glstub_glBufferDataARB" "glstub_glBufferDataARB"
external glBufferRegionEnabledEXT: unit -> int = "glstub_glBufferRegionEnabledEXT" "glstub_glBufferRegionEnabledEXT"
external glBufferSubData: int -> int -> int -> 'a -> unit = "glstub_glBufferSubData" "glstub_glBufferSubData"
external glBufferSubDataARB: int -> int -> int -> 'a -> unit = "glstub_glBufferSubDataARB" "glstub_glBufferSubDataARB"
external glCallList: int -> unit = "glstub_glCallList" "glstub_glCallList"
external glCallLists: int -> int -> 'a -> unit = "glstub_glCallLists" "glstub_glCallLists"
external glCheckFramebufferStatusEXT: int -> int = "glstub_glCheckFramebufferStatusEXT" "glstub_glCheckFramebufferStatusEXT"
external glClampColorARB: int -> int -> unit = "glstub_glClampColorARB" "glstub_glClampColorARB"
external glClear: int -> unit = "glstub_glClear" "glstub_glClear"
external glClearAccum: float -> float -> float -> float -> unit = "glstub_glClearAccum" "glstub_glClearAccum"
external glClearColor: float -> float -> float -> float -> unit = "glstub_glClearColor" "glstub_glClearColor"
external glClearColorIiEXT: int -> int -> int -> int -> unit = "glstub_glClearColorIiEXT" "glstub_glClearColorIiEXT"
external glClearColorIuiEXT: int -> int -> int -> int -> unit = "glstub_glClearColorIuiEXT" "glstub_glClearColorIuiEXT"
external glClearDepth: float -> unit = "glstub_glClearDepth" "glstub_glClearDepth"
external glClearDepthdNV: float -> unit = "glstub_glClearDepthdNV" "glstub_glClearDepthdNV"
external glClearDepthfOES: float -> unit = "glstub_glClearDepthfOES" "glstub_glClearDepthfOES"
external glClearIndex: float -> unit = "glstub_glClearIndex" "glstub_glClearIndex"
external glClearStencil: int -> unit = "glstub_glClearStencil" "glstub_glClearStencil"
external glClientActiveTexture: int -> unit = "glstub_glClientActiveTexture" "glstub_glClientActiveTexture"
external glClientActiveTextureARB: int -> unit = "glstub_glClientActiveTextureARB" "glstub_glClientActiveTextureARB"
external glClientActiveVertexStreamATI: int -> unit = "glstub_glClientActiveVertexStreamATI" "glstub_glClientActiveVertexStreamATI"
external glClipPlane: int -> float array -> unit = "glstub_glClipPlane" "glstub_glClipPlane"

external glClipPlanefOES: int -> float_array -> unit = "glstub_glClipPlanefOES" "glstub_glClipPlanefOES"
let glClipPlanefOES p0 p1 =
let np1 = to_float_array p1 in
let r = glClipPlanefOES p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glColor3b: int -> int -> int -> unit = "glstub_glColor3b" "glstub_glColor3b"

external glColor3bv: byte_array -> unit = "glstub_glColor3bv" "glstub_glColor3bv"
let glColor3bv p0 =
let np0 = to_byte_array p0 in
let r = glColor3bv np0 in
r

external glColor3d: float -> float -> float -> unit = "glstub_glColor3d" "glstub_glColor3d"
external glColor3dv: float array -> unit = "glstub_glColor3dv" "glstub_glColor3dv"
external glColor3f: float -> float -> float -> unit = "glstub_glColor3f" "glstub_glColor3f"
external glColor3fVertex3fSUN: float -> float -> float -> float -> float -> float -> unit = "glstub_glColor3fVertex3fSUN_byte" "glstub_glColor3fVertex3fSUN"

external glColor3fVertex3fvSUN: float_array -> float_array -> unit = "glstub_glColor3fVertex3fvSUN" "glstub_glColor3fVertex3fvSUN"
let glColor3fVertex3fvSUN p0 p1 =
let np0 = to_float_array p0 in
let np1 = to_float_array p1 in
let r = glColor3fVertex3fvSUN np0 np1 in
let _ = copy_float_array np0 p0 in
let _ = copy_float_array np1 p1 in
r


external glColor3fv: float_array -> unit = "glstub_glColor3fv" "glstub_glColor3fv"
let glColor3fv p0 =
let np0 = to_float_array p0 in
let r = glColor3fv np0 in
r

external glColor3hNV: int -> int -> int -> unit = "glstub_glColor3hNV" "glstub_glColor3hNV"

external glColor3hvNV: ushort_array -> unit = "glstub_glColor3hvNV" "glstub_glColor3hvNV"
let glColor3hvNV p0 =
let np0 = to_ushort_array p0 in
let r = glColor3hvNV np0 in
let _ = copy_ushort_array np0 p0 in
r

external glColor3i: int -> int -> int -> unit = "glstub_glColor3i" "glstub_glColor3i"

external glColor3iv: word_array -> unit = "glstub_glColor3iv" "glstub_glColor3iv"
let glColor3iv p0 =
let np0 = to_word_array p0 in
let r = glColor3iv np0 in
r

external glColor3s: int -> int -> int -> unit = "glstub_glColor3s" "glstub_glColor3s"

external glColor3sv: short_array -> unit = "glstub_glColor3sv" "glstub_glColor3sv"
let glColor3sv p0 =
let np0 = to_short_array p0 in
let r = glColor3sv np0 in
r

external glColor3ub: int -> int -> int -> unit = "glstub_glColor3ub" "glstub_glColor3ub"

external glColor3ubv: ubyte_array -> unit = "glstub_glColor3ubv" "glstub_glColor3ubv"
let glColor3ubv p0 =
let np0 = to_ubyte_array p0 in
let r = glColor3ubv np0 in
r

external glColor3ui: int -> int -> int -> unit = "glstub_glColor3ui" "glstub_glColor3ui"

external glColor3uiv: word_array -> unit = "glstub_glColor3uiv" "glstub_glColor3uiv"
let glColor3uiv p0 =
let np0 = to_word_array p0 in
let r = glColor3uiv np0 in
r

external glColor3us: int -> int -> int -> unit = "glstub_glColor3us" "glstub_glColor3us"

external glColor3usv: ushort_array -> unit = "glstub_glColor3usv" "glstub_glColor3usv"
let glColor3usv p0 =
let np0 = to_ushort_array p0 in
let r = glColor3usv np0 in
r

external glColor4b: int -> int -> int -> int -> unit = "glstub_glColor4b" "glstub_glColor4b"

external glColor4bv: byte_array -> unit = "glstub_glColor4bv" "glstub_glColor4bv"
let glColor4bv p0 =
let np0 = to_byte_array p0 in
let r = glColor4bv np0 in
r

external glColor4d: float -> float -> float -> float -> unit = "glstub_glColor4d" "glstub_glColor4d"
external glColor4dv: float array -> unit = "glstub_glColor4dv" "glstub_glColor4dv"
external glColor4f: float -> float -> float -> float -> unit = "glstub_glColor4f" "glstub_glColor4f"
external glColor4fNormal3fVertex3fSUN: float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> unit = "glstub_glColor4fNormal3fVertex3fSUN_byte" "glstub_glColor4fNormal3fVertex3fSUN"

external glColor4fNormal3fVertex3fvSUN: float_array -> float_array -> float_array -> unit = "glstub_glColor4fNormal3fVertex3fvSUN" "glstub_glColor4fNormal3fVertex3fvSUN"
let glColor4fNormal3fVertex3fvSUN p0 p1 p2 =
let np0 = to_float_array p0 in
let np1 = to_float_array p1 in
let np2 = to_float_array p2 in
let r = glColor4fNormal3fVertex3fvSUN np0 np1 np2 in
let _ = copy_float_array np0 p0 in
let _ = copy_float_array np1 p1 in
let _ = copy_float_array np2 p2 in
r


external glColor4fv: float_array -> unit = "glstub_glColor4fv" "glstub_glColor4fv"
let glColor4fv p0 =
let np0 = to_float_array p0 in
let r = glColor4fv np0 in
r

external glColor4hNV: int -> int -> int -> int -> unit = "glstub_glColor4hNV" "glstub_glColor4hNV"

external glColor4hvNV: ushort_array -> unit = "glstub_glColor4hvNV" "glstub_glColor4hvNV"
let glColor4hvNV p0 =
let np0 = to_ushort_array p0 in
let r = glColor4hvNV np0 in
let _ = copy_ushort_array np0 p0 in
r

external glColor4i: int -> int -> int -> int -> unit = "glstub_glColor4i" "glstub_glColor4i"

external glColor4iv: word_array -> unit = "glstub_glColor4iv" "glstub_glColor4iv"
let glColor4iv p0 =
let np0 = to_word_array p0 in
let r = glColor4iv np0 in
r

external glColor4s: int -> int -> int -> int -> unit = "glstub_glColor4s" "glstub_glColor4s"

external glColor4sv: short_array -> unit = "glstub_glColor4sv" "glstub_glColor4sv"
let glColor4sv p0 =
let np0 = to_short_array p0 in
let r = glColor4sv np0 in
r

external glColor4ub: int -> int -> int -> int -> unit = "glstub_glColor4ub" "glstub_glColor4ub"
external glColor4ubVertex2fSUN: int -> int -> int -> int -> float -> float -> unit = "glstub_glColor4ubVertex2fSUN_byte" "glstub_glColor4ubVertex2fSUN"

external glColor4ubVertex2fvSUN: ubyte_array -> float_array -> unit = "glstub_glColor4ubVertex2fvSUN" "glstub_glColor4ubVertex2fvSUN"
let glColor4ubVertex2fvSUN p0 p1 =
let np0 = to_ubyte_array p0 in
let np1 = to_float_array p1 in
let r = glColor4ubVertex2fvSUN np0 np1 in
let _ = copy_ubyte_array np0 p0 in
let _ = copy_float_array np1 p1 in
r

external glColor4ubVertex3fSUN: int -> int -> int -> int -> float -> float -> float -> unit = "glstub_glColor4ubVertex3fSUN_byte" "glstub_glColor4ubVertex3fSUN"

external glColor4ubVertex3fvSUN: ubyte_array -> float_array -> unit = "glstub_glColor4ubVertex3fvSUN" "glstub_glColor4ubVertex3fvSUN"
let glColor4ubVertex3fvSUN p0 p1 =
let np0 = to_ubyte_array p0 in
let np1 = to_float_array p1 in
let r = glColor4ubVertex3fvSUN np0 np1 in
let _ = copy_ubyte_array np0 p0 in
let _ = copy_float_array np1 p1 in
r


external glColor4ubv: ubyte_array -> unit = "glstub_glColor4ubv" "glstub_glColor4ubv"
let glColor4ubv p0 =
let np0 = to_ubyte_array p0 in
let r = glColor4ubv np0 in
r

external glColor4ui: int -> int -> int -> int -> unit = "glstub_glColor4ui" "glstub_glColor4ui"

external glColor4uiv: word_array -> unit = "glstub_glColor4uiv" "glstub_glColor4uiv"
let glColor4uiv p0 =
let np0 = to_word_array p0 in
let r = glColor4uiv np0 in
r

external glColor4us: int -> int -> int -> int -> unit = "glstub_glColor4us" "glstub_glColor4us"

external glColor4usv: ushort_array -> unit = "glstub_glColor4usv" "glstub_glColor4usv"
let glColor4usv p0 =
let np0 = to_ushort_array p0 in
let r = glColor4usv np0 in
r

external glColorFragmentOp1ATI: int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glColorFragmentOp1ATI_byte" "glstub_glColorFragmentOp1ATI"
external glColorFragmentOp2ATI: int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glColorFragmentOp2ATI_byte" "glstub_glColorFragmentOp2ATI"
external glColorFragmentOp3ATI: int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glColorFragmentOp3ATI_byte" "glstub_glColorFragmentOp3ATI"
external glColorMask: bool -> bool -> bool -> bool -> unit = "glstub_glColorMask" "glstub_glColorMask"
external glColorMaskIndexedEXT: int -> bool -> bool -> bool -> bool -> unit = "glstub_glColorMaskIndexedEXT" "glstub_glColorMaskIndexedEXT"
external glColorMaterial: int -> int -> unit = "glstub_glColorMaterial" "glstub_glColorMaterial"
external glColorPointer: int -> int -> int -> 'a -> unit = "glstub_glColorPointer" "glstub_glColorPointer"
external glColorPointerEXT: int -> int -> int -> int -> 'a -> unit = "glstub_glColorPointerEXT" "glstub_glColorPointerEXT"
external glColorPointerListIBM: int -> int -> int -> 'a -> int -> unit = "glstub_glColorPointerListIBM" "glstub_glColorPointerListIBM"
external glColorPointervINTEL: int -> int -> 'a -> unit = "glstub_glColorPointervINTEL" "glstub_glColorPointervINTEL"
external glColorSubTable: int -> int -> int -> int -> int -> 'a -> unit = "glstub_glColorSubTable_byte" "glstub_glColorSubTable"
external glColorSubTableEXT: int -> int -> int -> int -> int -> 'a -> unit = "glstub_glColorSubTableEXT_byte" "glstub_glColorSubTableEXT"
external glColorTable: int -> int -> int -> int -> int -> 'a -> unit = "glstub_glColorTable_byte" "glstub_glColorTable"
external glColorTableEXT: int -> int -> int -> int -> int -> 'a -> unit = "glstub_glColorTableEXT_byte" "glstub_glColorTableEXT"

external glColorTableParameterfv: int -> int -> float_array -> unit = "glstub_glColorTableParameterfv" "glstub_glColorTableParameterfv"
let glColorTableParameterfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glColorTableParameterfv p0 p1 np2 in
r


external glColorTableParameterfvSGI: int -> int -> float_array -> unit = "glstub_glColorTableParameterfvSGI" "glstub_glColorTableParameterfvSGI"
let glColorTableParameterfvSGI p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glColorTableParameterfvSGI p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glColorTableParameteriv: int -> int -> word_array -> unit = "glstub_glColorTableParameteriv" "glstub_glColorTableParameteriv"
let glColorTableParameteriv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glColorTableParameteriv p0 p1 np2 in
r


external glColorTableParameterivSGI: int -> int -> word_array -> unit = "glstub_glColorTableParameterivSGI" "glstub_glColorTableParameterivSGI"
let glColorTableParameterivSGI p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glColorTableParameterivSGI p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glColorTableSGI: int -> int -> int -> int -> int -> 'a -> unit = "glstub_glColorTableSGI_byte" "glstub_glColorTableSGI"
external glCombinerInputNV: int -> int -> int -> int -> int -> int -> unit = "glstub_glCombinerInputNV_byte" "glstub_glCombinerInputNV"
external glCombinerOutputNV: int -> int -> int -> int -> int -> int -> int -> bool -> bool -> bool -> unit = "glstub_glCombinerOutputNV_byte" "glstub_glCombinerOutputNV"
external glCombinerParameterfNV: int -> float -> unit = "glstub_glCombinerParameterfNV" "glstub_glCombinerParameterfNV"

external glCombinerParameterfvNV: int -> float_array -> unit = "glstub_glCombinerParameterfvNV" "glstub_glCombinerParameterfvNV"
let glCombinerParameterfvNV p0 p1 =
let np1 = to_float_array p1 in
let r = glCombinerParameterfvNV p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glCombinerParameteriNV: int -> int -> unit = "glstub_glCombinerParameteriNV" "glstub_glCombinerParameteriNV"

external glCombinerParameterivNV: int -> word_array -> unit = "glstub_glCombinerParameterivNV" "glstub_glCombinerParameterivNV"
let glCombinerParameterivNV p0 p1 =
let np1 = to_word_array p1 in
let r = glCombinerParameterivNV p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glCombinerStageParameterfvNV: int -> int -> float_array -> unit = "glstub_glCombinerStageParameterfvNV" "glstub_glCombinerStageParameterfvNV"
let glCombinerStageParameterfvNV p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glCombinerStageParameterfvNV p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glCompileShader: int -> unit = "glstub_glCompileShader" "glstub_glCompileShader"
external glCompileShaderARB: int -> unit = "glstub_glCompileShaderARB" "glstub_glCompileShaderARB"
external glCompressedTexImage1D: int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glCompressedTexImage1D_byte" "glstub_glCompressedTexImage1D"
external glCompressedTexImage1DARB: int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glCompressedTexImage1DARB_byte" "glstub_glCompressedTexImage1DARB"
external glCompressedTexImage2D: int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glCompressedTexImage2D_byte" "glstub_glCompressedTexImage2D"
external glCompressedTexImage2DARB: int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glCompressedTexImage2DARB_byte" "glstub_glCompressedTexImage2DARB"
external glCompressedTexImage3D: int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glCompressedTexImage3D_byte" "glstub_glCompressedTexImage3D"
external glCompressedTexImage3DARB: int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glCompressedTexImage3DARB_byte" "glstub_glCompressedTexImage3DARB"
external glCompressedTexSubImage1D: int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glCompressedTexSubImage1D_byte" "glstub_glCompressedTexSubImage1D"
external glCompressedTexSubImage1DARB: int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glCompressedTexSubImage1DARB_byte" "glstub_glCompressedTexSubImage1DARB"
external glCompressedTexSubImage2D: int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glCompressedTexSubImage2D_byte" "glstub_glCompressedTexSubImage2D"
external glCompressedTexSubImage2DARB: int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glCompressedTexSubImage2DARB_byte" "glstub_glCompressedTexSubImage2DARB"
external glCompressedTexSubImage3D: int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glCompressedTexSubImage3D_byte" "glstub_glCompressedTexSubImage3D"
external glCompressedTexSubImage3DARB: int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glCompressedTexSubImage3DARB_byte" "glstub_glCompressedTexSubImage3DARB"
external glConvolutionFilter1D: int -> int -> int -> int -> int -> 'a -> unit = "glstub_glConvolutionFilter1D_byte" "glstub_glConvolutionFilter1D"
external glConvolutionFilter1DEXT: int -> int -> int -> int -> int -> 'a -> unit = "glstub_glConvolutionFilter1DEXT_byte" "glstub_glConvolutionFilter1DEXT"
external glConvolutionFilter2D: int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glConvolutionFilter2D_byte" "glstub_glConvolutionFilter2D"
external glConvolutionFilter2DEXT: int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glConvolutionFilter2DEXT_byte" "glstub_glConvolutionFilter2DEXT"
external glConvolutionParameterf: int -> int -> float -> unit = "glstub_glConvolutionParameterf" "glstub_glConvolutionParameterf"
external glConvolutionParameterfEXT: int -> int -> float -> unit = "glstub_glConvolutionParameterfEXT" "glstub_glConvolutionParameterfEXT"

external glConvolutionParameterfv: int -> int -> float_array -> unit = "glstub_glConvolutionParameterfv" "glstub_glConvolutionParameterfv"
let glConvolutionParameterfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glConvolutionParameterfv p0 p1 np2 in
r


external glConvolutionParameterfvEXT: int -> int -> float_array -> unit = "glstub_glConvolutionParameterfvEXT" "glstub_glConvolutionParameterfvEXT"
let glConvolutionParameterfvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glConvolutionParameterfvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glConvolutionParameteri: int -> int -> int -> unit = "glstub_glConvolutionParameteri" "glstub_glConvolutionParameteri"
external glConvolutionParameteriEXT: int -> int -> int -> unit = "glstub_glConvolutionParameteriEXT" "glstub_glConvolutionParameteriEXT"

external glConvolutionParameteriv: int -> int -> word_array -> unit = "glstub_glConvolutionParameteriv" "glstub_glConvolutionParameteriv"
let glConvolutionParameteriv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glConvolutionParameteriv p0 p1 np2 in
r


external glConvolutionParameterivEXT: int -> int -> word_array -> unit = "glstub_glConvolutionParameterivEXT" "glstub_glConvolutionParameterivEXT"
let glConvolutionParameterivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glConvolutionParameterivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glCopyColorSubTable: int -> int -> int -> int -> int -> unit = "glstub_glCopyColorSubTable" "glstub_glCopyColorSubTable"
external glCopyColorSubTableEXT: int -> int -> int -> int -> int -> unit = "glstub_glCopyColorSubTableEXT" "glstub_glCopyColorSubTableEXT"
external glCopyColorTable: int -> int -> int -> int -> int -> unit = "glstub_glCopyColorTable" "glstub_glCopyColorTable"
external glCopyColorTableSGI: int -> int -> int -> int -> int -> unit = "glstub_glCopyColorTableSGI" "glstub_glCopyColorTableSGI"
external glCopyConvolutionFilter1D: int -> int -> int -> int -> int -> unit = "glstub_glCopyConvolutionFilter1D" "glstub_glCopyConvolutionFilter1D"
external glCopyConvolutionFilter1DEXT: int -> int -> int -> int -> int -> unit = "glstub_glCopyConvolutionFilter1DEXT" "glstub_glCopyConvolutionFilter1DEXT"
external glCopyConvolutionFilter2D: int -> int -> int -> int -> int -> int -> unit = "glstub_glCopyConvolutionFilter2D_byte" "glstub_glCopyConvolutionFilter2D"
external glCopyConvolutionFilter2DEXT: int -> int -> int -> int -> int -> int -> unit = "glstub_glCopyConvolutionFilter2DEXT_byte" "glstub_glCopyConvolutionFilter2DEXT"
external glCopyPixels: int -> int -> int -> int -> int -> unit = "glstub_glCopyPixels" "glstub_glCopyPixels"
external glCopyTexImage1D: int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glCopyTexImage1D_byte" "glstub_glCopyTexImage1D"
external glCopyTexImage1DEXT: int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glCopyTexImage1DEXT_byte" "glstub_glCopyTexImage1DEXT"
external glCopyTexImage2D: int -> int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glCopyTexImage2D_byte" "glstub_glCopyTexImage2D"
external glCopyTexImage2DEXT: int -> int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glCopyTexImage2DEXT_byte" "glstub_glCopyTexImage2DEXT"
external glCopyTexSubImage1D: int -> int -> int -> int -> int -> int -> unit = "glstub_glCopyTexSubImage1D_byte" "glstub_glCopyTexSubImage1D"
external glCopyTexSubImage1DEXT: int -> int -> int -> int -> int -> int -> unit = "glstub_glCopyTexSubImage1DEXT_byte" "glstub_glCopyTexSubImage1DEXT"
external glCopyTexSubImage2D: int -> int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glCopyTexSubImage2D_byte" "glstub_glCopyTexSubImage2D"
external glCopyTexSubImage2DEXT: int -> int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glCopyTexSubImage2DEXT_byte" "glstub_glCopyTexSubImage2DEXT"
external glCopyTexSubImage3D: int -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glCopyTexSubImage3D_byte" "glstub_glCopyTexSubImage3D"
external glCopyTexSubImage3DEXT: int -> int -> int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glCopyTexSubImage3DEXT_byte" "glstub_glCopyTexSubImage3DEXT"
external glCreateProgram: unit -> int = "glstub_glCreateProgram" "glstub_glCreateProgram"
external glCreateProgramObjectARB: unit -> int = "glstub_glCreateProgramObjectARB" "glstub_glCreateProgramObjectARB"
external glCreateShader: int -> int = "glstub_glCreateShader" "glstub_glCreateShader"
external glCreateShaderObjectARB: int -> int = "glstub_glCreateShaderObjectARB" "glstub_glCreateShaderObjectARB"
external glCullFace: int -> unit = "glstub_glCullFace" "glstub_glCullFace"
external glCullParameterdvEXT: int -> float array -> unit = "glstub_glCullParameterdvEXT" "glstub_glCullParameterdvEXT"

external glCullParameterfvEXT: int -> float_array -> unit = "glstub_glCullParameterfvEXT" "glstub_glCullParameterfvEXT"
let glCullParameterfvEXT p0 p1 =
let np1 = to_float_array p1 in
let r = glCullParameterfvEXT p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glCurrentPaletteMatrixARB: int -> unit = "glstub_glCurrentPaletteMatrixARB" "glstub_glCurrentPaletteMatrixARB"
external glDeleteAsyncMarkersSGIX: int -> int -> unit = "glstub_glDeleteAsyncMarkersSGIX" "glstub_glDeleteAsyncMarkersSGIX"
external glDeleteBufferRegionEXT: int -> unit = "glstub_glDeleteBufferRegionEXT" "glstub_glDeleteBufferRegionEXT"

external glDeleteBuffers: int -> word_array -> unit = "glstub_glDeleteBuffers" "glstub_glDeleteBuffers"
let glDeleteBuffers p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteBuffers p0 np1 in
r


external glDeleteBuffersARB: int -> word_array -> unit = "glstub_glDeleteBuffersARB" "glstub_glDeleteBuffersARB"
let glDeleteBuffersARB p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteBuffersARB p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glDeleteFencesAPPLE: int -> word_array -> unit = "glstub_glDeleteFencesAPPLE" "glstub_glDeleteFencesAPPLE"
let glDeleteFencesAPPLE p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteFencesAPPLE p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glDeleteFencesNV: int -> word_array -> unit = "glstub_glDeleteFencesNV" "glstub_glDeleteFencesNV"
let glDeleteFencesNV p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteFencesNV p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glDeleteFragmentShaderATI: int -> unit = "glstub_glDeleteFragmentShaderATI" "glstub_glDeleteFragmentShaderATI"

external glDeleteFramebuffersEXT: int -> word_array -> unit = "glstub_glDeleteFramebuffersEXT" "glstub_glDeleteFramebuffersEXT"
let glDeleteFramebuffersEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteFramebuffersEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glDeleteLists: int -> int -> unit = "glstub_glDeleteLists" "glstub_glDeleteLists"
external glDeleteObjectARB: int -> unit = "glstub_glDeleteObjectARB" "glstub_glDeleteObjectARB"

external glDeleteOcclusionQueriesNV: int -> word_array -> unit = "glstub_glDeleteOcclusionQueriesNV" "glstub_glDeleteOcclusionQueriesNV"
let glDeleteOcclusionQueriesNV p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteOcclusionQueriesNV p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glDeleteProgram: int -> unit = "glstub_glDeleteProgram" "glstub_glDeleteProgram"

external glDeleteProgramsARB: int -> word_array -> unit = "glstub_glDeleteProgramsARB" "glstub_glDeleteProgramsARB"
let glDeleteProgramsARB p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteProgramsARB p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glDeleteProgramsNV: int -> word_array -> unit = "glstub_glDeleteProgramsNV" "glstub_glDeleteProgramsNV"
let glDeleteProgramsNV p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteProgramsNV p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glDeleteQueries: int -> word_array -> unit = "glstub_glDeleteQueries" "glstub_glDeleteQueries"
let glDeleteQueries p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteQueries p0 np1 in
r


external glDeleteQueriesARB: int -> word_array -> unit = "glstub_glDeleteQueriesARB" "glstub_glDeleteQueriesARB"
let glDeleteQueriesARB p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteQueriesARB p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glDeleteRenderbuffersEXT: int -> word_array -> unit = "glstub_glDeleteRenderbuffersEXT" "glstub_glDeleteRenderbuffersEXT"
let glDeleteRenderbuffersEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteRenderbuffersEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glDeleteShader: int -> unit = "glstub_glDeleteShader" "glstub_glDeleteShader"

external glDeleteTextures: int -> word_array -> unit = "glstub_glDeleteTextures" "glstub_glDeleteTextures"
let glDeleteTextures p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteTextures p0 np1 in
r


external glDeleteTexturesEXT: int -> word_array -> unit = "glstub_glDeleteTexturesEXT" "glstub_glDeleteTexturesEXT"
let glDeleteTexturesEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteTexturesEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glDeleteVertexArraysAPPLE: int -> word_array -> unit = "glstub_glDeleteVertexArraysAPPLE" "glstub_glDeleteVertexArraysAPPLE"
let glDeleteVertexArraysAPPLE p0 p1 =
let np1 = to_word_array p1 in
let r = glDeleteVertexArraysAPPLE p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glDeleteVertexShaderEXT: int -> unit = "glstub_glDeleteVertexShaderEXT" "glstub_glDeleteVertexShaderEXT"
external glDepthBoundsEXT: float -> float -> unit = "glstub_glDepthBoundsEXT" "glstub_glDepthBoundsEXT"
external glDepthBoundsdNV: float -> float -> unit = "glstub_glDepthBoundsdNV" "glstub_glDepthBoundsdNV"
external glDepthFunc: int -> unit = "glstub_glDepthFunc" "glstub_glDepthFunc"
external glDepthMask: bool -> unit = "glstub_glDepthMask" "glstub_glDepthMask"
external glDepthRange: float -> float -> unit = "glstub_glDepthRange" "glstub_glDepthRange"
external glDepthRangedNV: float -> float -> unit = "glstub_glDepthRangedNV" "glstub_glDepthRangedNV"
external glDepthRangefOES: float -> float -> unit = "glstub_glDepthRangefOES" "glstub_glDepthRangefOES"
external glDetachObjectARB: int -> int -> unit = "glstub_glDetachObjectARB" "glstub_glDetachObjectARB"
external glDetachShader: int -> int -> unit = "glstub_glDetachShader" "glstub_glDetachShader"

external glDetailTexFuncSGIS: int -> int -> float_array -> unit = "glstub_glDetailTexFuncSGIS" "glstub_glDetailTexFuncSGIS"
let glDetailTexFuncSGIS p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glDetailTexFuncSGIS p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glDisable: int -> unit = "glstub_glDisable" "glstub_glDisable"
external glDisableClientState: int -> unit = "glstub_glDisableClientState" "glstub_glDisableClientState"
external glDisableIndexedEXT: int -> int -> unit = "glstub_glDisableIndexedEXT" "glstub_glDisableIndexedEXT"
external glDisableVariantClientStateEXT: int -> unit = "glstub_glDisableVariantClientStateEXT" "glstub_glDisableVariantClientStateEXT"
external glDisableVertexAttribArray: int -> unit = "glstub_glDisableVertexAttribArray" "glstub_glDisableVertexAttribArray"
external glDisableVertexAttribArrayARB: int -> unit = "glstub_glDisableVertexAttribArrayARB" "glstub_glDisableVertexAttribArrayARB"
external glDrawArrays: int -> int -> int -> unit = "glstub_glDrawArrays" "glstub_glDrawArrays"
external glDrawArraysEXT: int -> int -> int -> unit = "glstub_glDrawArraysEXT" "glstub_glDrawArraysEXT"
external glDrawArraysInstancedEXT: int -> int -> int -> int -> unit = "glstub_glDrawArraysInstancedEXT" "glstub_glDrawArraysInstancedEXT"
external glDrawBuffer: int -> unit = "glstub_glDrawBuffer" "glstub_glDrawBuffer"
external glDrawBufferRegionEXT: int -> int -> int -> int -> int -> int -> int -> unit = "glstub_glDrawBufferRegionEXT_byte" "glstub_glDrawBufferRegionEXT"

external glDrawBuffers: int -> word_array -> unit = "glstub_glDrawBuffers" "glstub_glDrawBuffers"
let glDrawBuffers p0 p1 =
let np1 = to_word_array p1 in
let r = glDrawBuffers p0 np1 in
r


external glDrawBuffersARB: int -> word_array -> unit = "glstub_glDrawBuffersARB" "glstub_glDrawBuffersARB"
let glDrawBuffersARB p0 p1 =
let np1 = to_word_array p1 in
let r = glDrawBuffersARB p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glDrawBuffersATI: int -> word_array -> unit = "glstub_glDrawBuffersATI" "glstub_glDrawBuffersATI"
let glDrawBuffersATI p0 p1 =
let np1 = to_word_array p1 in
let r = glDrawBuffersATI p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glDrawElementArrayAPPLE: int -> int -> int -> unit = "glstub_glDrawElementArrayAPPLE" "glstub_glDrawElementArrayAPPLE"
external glDrawElementArrayATI: int -> int -> unit = "glstub_glDrawElementArrayATI" "glstub_glDrawElementArrayATI"
external glDrawElements: int -> int -> int -> 'a -> unit = "glstub_glDrawElements" "glstub_glDrawElements"
external glDrawElementsInstancedEXT: int -> int -> int -> 'a -> int -> unit = "glstub_glDrawElementsInstancedEXT" "glstub_glDrawElementsInstancedEXT"
external glDrawPixels: int -> int -> int -> int -> 'a -> unit = "glstub_glDrawPixels" "glstub_glDrawPixels"
external glDrawRangeElementArrayAPPLE: int -> int -> int -> int -> int -> unit = "glstub_glDrawRangeElementArrayAPPLE" "glstub_glDrawRangeElementArrayAPPLE"
external glDrawRangeElementArrayATI: int -> int -> int -> int -> unit = "glstub_glDrawRangeElementArrayATI" "glstub_glDrawRangeElementArrayATI"
external glDrawRangeElements: int -> int -> int -> int -> int -> 'a -> unit = "glstub_glDrawRangeElements_byte" "glstub_glDrawRangeElements"
external glDrawRangeElementsEXT: int -> int -> int -> int -> int -> 'a -> unit = "glstub_glDrawRangeElementsEXT_byte" "glstub_glDrawRangeElementsEXT"
external glEdgeFlag: bool -> unit = "glstub_glEdgeFlag" "glstub_glEdgeFlag"
external glEdgeFlagPointer: int -> 'a -> unit = "glstub_glEdgeFlagPointer" "glstub_glEdgeFlagPointer"

external glEdgeFlagPointerEXT: int -> int -> word_array -> unit = "glstub_glEdgeFlagPointerEXT" "glstub_glEdgeFlagPointerEXT"
let glEdgeFlagPointerEXT p0 p1 p2 =
let np2 = to_word_array (bool_to_int_array p2) in
let r = glEdgeFlagPointerEXT p0 p1 np2 in
let bp2 =  Array.create (Bigarray.Array1.dim np2) 0 in
let _ = copy_word_array np2 bp2 in
let _ = copy_to_bool_array bp2 p2 in
r

external glEdgeFlagPointerListIBM: int -> word_matrix -> int -> unit = "glstub_glEdgeFlagPointerListIBM" "glstub_glEdgeFlagPointerListIBM"

external glEdgeFlagv: word_array -> unit = "glstub_glEdgeFlagv" "glstub_glEdgeFlagv"
let glEdgeFlagv p0 =
let np0 = to_word_array (bool_to_int_array p0) in
let r = glEdgeFlagv np0 in
r

external glElementPointerAPPLE: int -> 'a -> unit = "glstub_glElementPointerAPPLE" "glstub_glElementPointerAPPLE"
external glElementPointerATI: int -> 'a -> unit = "glstub_glElementPointerATI" "glstub_glElementPointerATI"
external glEnable: int -> unit = "glstub_glEnable" "glstub_glEnable"
external glEnableClientState: int -> unit = "glstub_glEnableClientState" "glstub_glEnableClientState"
external glEnableIndexedEXT: int -> int -> unit = "glstub_glEnableIndexedEXT" "glstub_glEnableIndexedEXT"
external glEnableVariantClientStateEXT: int -> unit = "glstub_glEnableVariantClientStateEXT" "glstub_glEnableVariantClientStateEXT"
external glEnableVertexAttribArray: int -> unit = "glstub_glEnableVertexAttribArray" "glstub_glEnableVertexAttribArray"
external glEnableVertexAttribArrayARB: int -> unit = "glstub_glEnableVertexAttribArrayARB" "glstub_glEnableVertexAttribArrayARB"
external glEnd: unit -> unit = "glstub_glEnd" "glstub_glEnd"
external glEndFragmentShaderATI: unit -> unit = "glstub_glEndFragmentShaderATI" "glstub_glEndFragmentShaderATI"
external glEndList: unit -> unit = "glstub_glEndList" "glstub_glEndList"
external glEndOcclusionQueryNV: unit -> unit = "glstub_glEndOcclusionQueryNV" "glstub_glEndOcclusionQueryNV"
external glEndQuery: int -> unit = "glstub_glEndQuery" "glstub_glEndQuery"
external glEndQueryARB: int -> unit = "glstub_glEndQueryARB" "glstub_glEndQueryARB"
external glEndSceneEXT: unit -> unit = "glstub_glEndSceneEXT" "glstub_glEndSceneEXT"
external glEndTransformFeedbackNV: unit -> unit = "glstub_glEndTransformFeedbackNV" "glstub_glEndTransformFeedbackNV"
external glEndVertexShaderEXT: unit -> unit = "glstub_glEndVertexShaderEXT" "glstub_glEndVertexShaderEXT"
external glEvalCoord1d: float -> unit = "glstub_glEvalCoord1d" "glstub_glEvalCoord1d"
external glEvalCoord1dv: float array -> unit = "glstub_glEvalCoord1dv" "glstub_glEvalCoord1dv"
external glEvalCoord1f: float -> unit = "glstub_glEvalCoord1f" "glstub_glEvalCoord1f"

external glEvalCoord1fv: float_array -> unit = "glstub_glEvalCoord1fv" "glstub_glEvalCoord1fv"
let glEvalCoord1fv p0 =
let np0 = to_float_array p0 in
let r = glEvalCoord1fv np0 in
r

external glEvalCoord2d: float -> float -> unit = "glstub_glEvalCoord2d" "glstub_glEvalCoord2d"
external glEvalCoord2dv: float array -> unit = "glstub_glEvalCoord2dv" "glstub_glEvalCoord2dv"
external glEvalCoord2f: float -> float -> unit = "glstub_glEvalCoord2f" "glstub_glEvalCoord2f"

external glEvalCoord2fv: float_array -> unit = "glstub_glEvalCoord2fv" "glstub_glEvalCoord2fv"
let glEvalCoord2fv p0 =
let np0 = to_float_array p0 in
let r = glEvalCoord2fv np0 in
r

external glEvalMapsNV: int -> int -> unit = "glstub_glEvalMapsNV" "glstub_glEvalMapsNV"
external glEvalMesh1: int -> int -> int -> unit = "glstub_glEvalMesh1" "glstub_glEvalMesh1"
external glEvalMesh2: int -> int -> int -> int -> int -> unit = "glstub_glEvalMesh2" "glstub_glEvalMesh2"
external glEvalPoint1: int -> unit = "glstub_glEvalPoint1" "glstub_glEvalPoint1"
external glEvalPoint2: int -> int -> unit = "glstub_glEvalPoint2" "glstub_glEvalPoint2"

external glExecuteProgramNV: int -> int -> float_array -> unit = "glstub_glExecuteProgramNV" "glstub_glExecuteProgramNV"
let glExecuteProgramNV p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glExecuteProgramNV p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glExtractComponentEXT: int -> int -> int -> unit = "glstub_glExtractComponentEXT" "glstub_glExtractComponentEXT"

external glFeedbackBuffer: int -> int -> float_array -> unit = "glstub_glFeedbackBuffer" "glstub_glFeedbackBuffer"
let glFeedbackBuffer p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glFeedbackBuffer p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glFinalCombinerInputNV: int -> int -> int -> int -> unit = "glstub_glFinalCombinerInputNV" "glstub_glFinalCombinerInputNV"
external glFinish: unit -> unit = "glstub_glFinish" "glstub_glFinish"

external glFinishAsyncSGIX: word_array -> int = "glstub_glFinishAsyncSGIX" "glstub_glFinishAsyncSGIX"
let glFinishAsyncSGIX p0 =
let np0 = to_word_array p0 in
let r = glFinishAsyncSGIX np0 in
let _ = copy_word_array np0 p0 in
r

external glFinishFenceAPPLE: int -> unit = "glstub_glFinishFenceAPPLE" "glstub_glFinishFenceAPPLE"
external glFinishFenceNV: int -> unit = "glstub_glFinishFenceNV" "glstub_glFinishFenceNV"
external glFinishObjectAPPLE: int -> int -> unit = "glstub_glFinishObjectAPPLE" "glstub_glFinishObjectAPPLE"
external glFinishTextureSUNX: unit -> unit = "glstub_glFinishTextureSUNX" "glstub_glFinishTextureSUNX"
external glFlush: unit -> unit = "glstub_glFlush" "glstub_glFlush"
external glFlushPixelDataRangeNV: int -> unit = "glstub_glFlushPixelDataRangeNV" "glstub_glFlushPixelDataRangeNV"
external glFlushRasterSGIX: unit -> unit = "glstub_glFlushRasterSGIX" "glstub_glFlushRasterSGIX"
external glFlushVertexArrayRangeAPPLE: int -> 'a -> unit = "glstub_glFlushVertexArrayRangeAPPLE" "glstub_glFlushVertexArrayRangeAPPLE"
external glFlushVertexArrayRangeNV: unit -> unit = "glstub_glFlushVertexArrayRangeNV" "glstub_glFlushVertexArrayRangeNV"
external glFogCoordPointer: int -> int -> 'a -> unit = "glstub_glFogCoordPointer" "glstub_glFogCoordPointer"
external glFogCoordPointerEXT: int -> int -> 'a -> unit = "glstub_glFogCoordPointerEXT" "glstub_glFogCoordPointerEXT"
external glFogCoordPointerListIBM: int -> int -> 'a -> int -> unit = "glstub_glFogCoordPointerListIBM" "glstub_glFogCoordPointerListIBM"
external glFogCoordd: float -> unit = "glstub_glFogCoordd" "glstub_glFogCoordd"
external glFogCoorddEXT: float -> unit = "glstub_glFogCoorddEXT" "glstub_glFogCoorddEXT"
external glFogCoorddv: float array -> unit = "glstub_glFogCoorddv" "glstub_glFogCoorddv"
external glFogCoorddvEXT: float array -> unit = "glstub_glFogCoorddvEXT" "glstub_glFogCoorddvEXT"
external glFogCoordf: float -> unit = "glstub_glFogCoordf" "glstub_glFogCoordf"
external glFogCoordfEXT: float -> unit = "glstub_glFogCoordfEXT" "glstub_glFogCoordfEXT"

external glFogCoordfv: float_array -> unit = "glstub_glFogCoordfv" "glstub_glFogCoordfv"
let glFogCoordfv p0 =
let np0 = to_float_array p0 in
let r = glFogCoordfv np0 in
r


external glFogCoordfvEXT: float_array -> unit = "glstub_glFogCoordfvEXT" "glstub_glFogCoordfvEXT"
let glFogCoordfvEXT p0 =
let np0 = to_float_array p0 in
let r = glFogCoordfvEXT np0 in
r

external glFogCoordhNV: int -> unit = "glstub_glFogCoordhNV" "glstub_glFogCoordhNV"

external glFogCoordhvNV: ushort_array -> unit = "glstub_glFogCoordhvNV" "glstub_glFogCoordhvNV"
let glFogCoordhvNV p0 =
let np0 = to_ushort_array p0 in
let r = glFogCoordhvNV np0 in
let _ = copy_ushort_array np0 p0 in
r


external glFogFuncSGIS: int -> float_array -> unit = "glstub_glFogFuncSGIS" "glstub_glFogFuncSGIS"
let glFogFuncSGIS p0 p1 =
let np1 = to_float_array p1 in
let r = glFogFuncSGIS p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glFogf: int -> float -> unit = "glstub_glFogf" "glstub_glFogf"

external glFogfv: int -> float_array -> unit = "glstub_glFogfv" "glstub_glFogfv"
let glFogfv p0 p1 =
let np1 = to_float_array p1 in
let r = glFogfv p0 np1 in
r

external glFogi: int -> int -> unit = "glstub_glFogi" "glstub_glFogi"

external glFogiv: int -> word_array -> unit = "glstub_glFogiv" "glstub_glFogiv"
let glFogiv p0 p1 =
let np1 = to_word_array p1 in
let r = glFogiv p0 np1 in
r

external glFragmentColorMaterialEXT: int -> int -> unit = "glstub_glFragmentColorMaterialEXT" "glstub_glFragmentColorMaterialEXT"
external glFragmentColorMaterialSGIX: int -> int -> unit = "glstub_glFragmentColorMaterialSGIX" "glstub_glFragmentColorMaterialSGIX"
external glFragmentLightModelfEXT: int -> float -> unit = "glstub_glFragmentLightModelfEXT" "glstub_glFragmentLightModelfEXT"
external glFragmentLightModelfSGIX: int -> float -> unit = "glstub_glFragmentLightModelfSGIX" "glstub_glFragmentLightModelfSGIX"

external glFragmentLightModelfvEXT: int -> float_array -> unit = "glstub_glFragmentLightModelfvEXT" "glstub_glFragmentLightModelfvEXT"
let glFragmentLightModelfvEXT p0 p1 =
let np1 = to_float_array p1 in
let r = glFragmentLightModelfvEXT p0 np1 in
let _ = copy_float_array np1 p1 in
r


external glFragmentLightModelfvSGIX: int -> float_array -> unit = "glstub_glFragmentLightModelfvSGIX" "glstub_glFragmentLightModelfvSGIX"
let glFragmentLightModelfvSGIX p0 p1 =
let np1 = to_float_array p1 in
let r = glFragmentLightModelfvSGIX p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glFragmentLightModeliEXT: int -> int -> unit = "glstub_glFragmentLightModeliEXT" "glstub_glFragmentLightModeliEXT"
external glFragmentLightModeliSGIX: int -> int -> unit = "glstub_glFragmentLightModeliSGIX" "glstub_glFragmentLightModeliSGIX"

external glFragmentLightModelivEXT: int -> word_array -> unit = "glstub_glFragmentLightModelivEXT" "glstub_glFragmentLightModelivEXT"
let glFragmentLightModelivEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glFragmentLightModelivEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glFragmentLightModelivSGIX: int -> word_array -> unit = "glstub_glFragmentLightModelivSGIX" "glstub_glFragmentLightModelivSGIX"
let glFragmentLightModelivSGIX p0 p1 =
let np1 = to_word_array p1 in
let r = glFragmentLightModelivSGIX p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glFragmentLightfEXT: int -> int -> float -> unit = "glstub_glFragmentLightfEXT" "glstub_glFragmentLightfEXT"
external glFragmentLightfSGIX: int -> int -> float -> unit = "glstub_glFragmentLightfSGIX" "glstub_glFragmentLightfSGIX"

external glFragmentLightfvEXT: int -> int -> float_array -> unit = "glstub_glFragmentLightfvEXT" "glstub_glFragmentLightfvEXT"
let glFragmentLightfvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glFragmentLightfvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glFragmentLightfvSGIX: int -> int -> float_array -> unit = "glstub_glFragmentLightfvSGIX" "glstub_glFragmentLightfvSGIX"
let glFragmentLightfvSGIX p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glFragmentLightfvSGIX p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glFragmentLightiEXT: int -> int -> int -> unit = "glstub_glFragmentLightiEXT" "glstub_glFragmentLightiEXT"
external glFragmentLightiSGIX: int -> int -> int -> unit = "glstub_glFragmentLightiSGIX" "glstub_glFragmentLightiSGIX"

external glFragmentLightivEXT: int -> int -> word_array -> unit = "glstub_glFragmentLightivEXT" "glstub_glFragmentLightivEXT"
let glFragmentLightivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glFragmentLightivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glFragmentLightivSGIX: int -> int -> word_array -> unit = "glstub_glFragmentLightivSGIX" "glstub_glFragmentLightivSGIX"
let glFragmentLightivSGIX p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glFragmentLightivSGIX p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glFragmentMaterialfEXT: int -> int -> float -> unit = "glstub_glFragmentMaterialfEXT" "glstub_glFragmentMaterialfEXT"
external glFragmentMaterialfSGIX: int -> int -> float -> unit = "glstub_glFragmentMaterialfSGIX" "glstub_glFragmentMaterialfSGIX"

external glFragmentMaterialfvEXT: int -> int -> float_array -> unit = "glstub_glFragmentMaterialfvEXT" "glstub_glFragmentMaterialfvEXT"
let glFragmentMaterialfvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glFragmentMaterialfvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glFragmentMaterialfvSGIX: int -> int -> float_array -> unit = "glstub_glFragmentMaterialfvSGIX" "glstub_glFragmentMaterialfvSGIX"
let glFragmentMaterialfvSGIX p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glFragmentMaterialfvSGIX p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glFragmentMaterialiEXT: int -> int -> int -> unit = "glstub_glFragmentMaterialiEXT" "glstub_glFragmentMaterialiEXT"
external glFragmentMaterialiSGIX: int -> int -> int -> unit = "glstub_glFragmentMaterialiSGIX" "glstub_glFragmentMaterialiSGIX"

external glFragmentMaterialivEXT: int -> int -> word_array -> unit = "glstub_glFragmentMaterialivEXT" "glstub_glFragmentMaterialivEXT"
let glFragmentMaterialivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glFragmentMaterialivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glFragmentMaterialivSGIX: int -> int -> word_array -> unit = "glstub_glFragmentMaterialivSGIX" "glstub_glFragmentMaterialivSGIX"
let glFragmentMaterialivSGIX p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glFragmentMaterialivSGIX p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glFrameZoomSGIX: int -> unit = "glstub_glFrameZoomSGIX" "glstub_glFrameZoomSGIX"
external glFramebufferRenderbufferEXT: int -> int -> int -> int -> unit = "glstub_glFramebufferRenderbufferEXT" "glstub_glFramebufferRenderbufferEXT"
external glFramebufferTexture1DEXT: int -> int -> int -> int -> int -> unit = "glstub_glFramebufferTexture1DEXT" "glstub_glFramebufferTexture1DEXT"
external glFramebufferTexture2DEXT: int -> int -> int -> int -> int -> unit = "glstub_glFramebufferTexture2DEXT" "glstub_glFramebufferTexture2DEXT"
external glFramebufferTexture3DEXT: int -> int -> int -> int -> int -> int -> unit = "glstub_glFramebufferTexture3DEXT_byte" "glstub_glFramebufferTexture3DEXT"
external glFramebufferTextureEXT: int -> int -> int -> int -> unit = "glstub_glFramebufferTextureEXT" "glstub_glFramebufferTextureEXT"
external glFramebufferTextureFaceEXT: int -> int -> int -> int -> int -> unit = "glstub_glFramebufferTextureFaceEXT" "glstub_glFramebufferTextureFaceEXT"
external glFramebufferTextureLayerEXT: int -> int -> int -> int -> int -> unit = "glstub_glFramebufferTextureLayerEXT" "glstub_glFramebufferTextureLayerEXT"
external glFreeObjectBufferATI: int -> unit = "glstub_glFreeObjectBufferATI" "glstub_glFreeObjectBufferATI"
external glFrontFace: int -> unit = "glstub_glFrontFace" "glstub_glFrontFace"
external glFrustum: float -> float -> float -> float -> float -> float -> unit = "glstub_glFrustum_byte" "glstub_glFrustum"
external glFrustumfOES: float -> float -> float -> float -> float -> float -> unit = "glstub_glFrustumfOES_byte" "glstub_glFrustumfOES"
external glGenAsyncMarkersSGIX: int -> int = "glstub_glGenAsyncMarkersSGIX" "glstub_glGenAsyncMarkersSGIX"

external glGenBuffers: int -> word_array -> unit = "glstub_glGenBuffers" "glstub_glGenBuffers"
let glGenBuffers p0 p1 =
let np1 = to_word_array p1 in
let r = glGenBuffers p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glGenBuffersARB: int -> word_array -> unit = "glstub_glGenBuffersARB" "glstub_glGenBuffersARB"
let glGenBuffersARB p0 p1 =
let np1 = to_word_array p1 in
let r = glGenBuffersARB p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glGenFencesAPPLE: int -> word_array -> unit = "glstub_glGenFencesAPPLE" "glstub_glGenFencesAPPLE"
let glGenFencesAPPLE p0 p1 =
let np1 = to_word_array p1 in
let r = glGenFencesAPPLE p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glGenFencesNV: int -> word_array -> unit = "glstub_glGenFencesNV" "glstub_glGenFencesNV"
let glGenFencesNV p0 p1 =
let np1 = to_word_array p1 in
let r = glGenFencesNV p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glGenFragmentShadersATI: int -> int = "glstub_glGenFragmentShadersATI" "glstub_glGenFragmentShadersATI"

external glGenFramebuffersEXT: int -> word_array -> unit = "glstub_glGenFramebuffersEXT" "glstub_glGenFramebuffersEXT"
let glGenFramebuffersEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glGenFramebuffersEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glGenLists: int -> int = "glstub_glGenLists" "glstub_glGenLists"

external glGenOcclusionQueriesNV: int -> word_array -> unit = "glstub_glGenOcclusionQueriesNV" "glstub_glGenOcclusionQueriesNV"
let glGenOcclusionQueriesNV p0 p1 =
let np1 = to_word_array p1 in
let r = glGenOcclusionQueriesNV p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glGenProgramsARB: int -> word_array -> unit = "glstub_glGenProgramsARB" "glstub_glGenProgramsARB"
let glGenProgramsARB p0 p1 =
let np1 = to_word_array p1 in
let r = glGenProgramsARB p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glGenProgramsNV: int -> word_array -> unit = "glstub_glGenProgramsNV" "glstub_glGenProgramsNV"
let glGenProgramsNV p0 p1 =
let np1 = to_word_array p1 in
let r = glGenProgramsNV p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glGenQueries: int -> word_array -> unit = "glstub_glGenQueries" "glstub_glGenQueries"
let glGenQueries p0 p1 =
let np1 = to_word_array p1 in
let r = glGenQueries p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glGenQueriesARB: int -> word_array -> unit = "glstub_glGenQueriesARB" "glstub_glGenQueriesARB"
let glGenQueriesARB p0 p1 =
let np1 = to_word_array p1 in
let r = glGenQueriesARB p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glGenRenderbuffersEXT: int -> word_array -> unit = "glstub_glGenRenderbuffersEXT" "glstub_glGenRenderbuffersEXT"
let glGenRenderbuffersEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glGenRenderbuffersEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glGenSymbolsEXT: int -> int -> int -> int -> int = "glstub_glGenSymbolsEXT" "glstub_glGenSymbolsEXT"

external glGenTextures: int -> word_array -> unit = "glstub_glGenTextures" "glstub_glGenTextures"
let glGenTextures p0 p1 =
let np1 = to_word_array p1 in
let r = glGenTextures p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glGenTexturesEXT: int -> word_array -> unit = "glstub_glGenTexturesEXT" "glstub_glGenTexturesEXT"
let glGenTexturesEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glGenTexturesEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glGenVertexArraysAPPLE: int -> word_array -> unit = "glstub_glGenVertexArraysAPPLE" "glstub_glGenVertexArraysAPPLE"
let glGenVertexArraysAPPLE p0 p1 =
let np1 = to_word_array p1 in
let r = glGenVertexArraysAPPLE p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glGenVertexShadersEXT: int -> int = "glstub_glGenVertexShadersEXT" "glstub_glGenVertexShadersEXT"
external glGenerateMipmapEXT: int -> unit = "glstub_glGenerateMipmapEXT" "glstub_glGenerateMipmapEXT"

external glGetActiveAttrib: int -> int -> int -> word_array -> word_array -> word_array -> string -> unit = "glstub_glGetActiveAttrib_byte" "glstub_glGetActiveAttrib"
let glGetActiveAttrib p0 p1 p2 p3 p4 p5 p6 =
let np3 = to_word_array p3 in
let np4 = to_word_array p4 in
let np5 = to_word_array p5 in
let r = glGetActiveAttrib p0 p1 p2 np3 np4 np5 p6 in
let _ = copy_word_array np3 p3 in
let _ = copy_word_array np4 p4 in
let _ = copy_word_array np5 p5 in
r


external glGetActiveAttribARB: int -> int -> int -> word_array -> word_array -> word_array -> string -> unit = "glstub_glGetActiveAttribARB_byte" "glstub_glGetActiveAttribARB"
let glGetActiveAttribARB p0 p1 p2 p3 p4 p5 p6 =
let np3 = to_word_array p3 in
let np4 = to_word_array p4 in
let np5 = to_word_array p5 in
let r = glGetActiveAttribARB p0 p1 p2 np3 np4 np5 p6 in
let _ = copy_word_array np3 p3 in
let _ = copy_word_array np4 p4 in
let _ = copy_word_array np5 p5 in
r


external glGetActiveUniform: int -> int -> int -> word_array -> word_array -> word_array -> string -> unit = "glstub_glGetActiveUniform_byte" "glstub_glGetActiveUniform"
let glGetActiveUniform p0 p1 p2 p3 p4 p5 p6 =
let np3 = to_word_array p3 in
let np4 = to_word_array p4 in
let np5 = to_word_array p5 in
let r = glGetActiveUniform p0 p1 p2 np3 np4 np5 p6 in
let _ = copy_word_array np3 p3 in
let _ = copy_word_array np4 p4 in
let _ = copy_word_array np5 p5 in
r


external glGetActiveUniformARB: int -> int -> int -> word_array -> word_array -> word_array -> string -> unit = "glstub_glGetActiveUniformARB_byte" "glstub_glGetActiveUniformARB"
let glGetActiveUniformARB p0 p1 p2 p3 p4 p5 p6 =
let np3 = to_word_array p3 in
let np4 = to_word_array p4 in
let np5 = to_word_array p5 in
let r = glGetActiveUniformARB p0 p1 p2 np3 np4 np5 p6 in
let _ = copy_word_array np3 p3 in
let _ = copy_word_array np4 p4 in
let _ = copy_word_array np5 p5 in
r


external glGetActiveVaryingNV: int -> int -> int -> word_array -> word_array -> word_array -> string -> unit = "glstub_glGetActiveVaryingNV_byte" "glstub_glGetActiveVaryingNV"
let glGetActiveVaryingNV p0 p1 p2 p3 p4 p5 p6 =
let np3 = to_word_array p3 in
let np4 = to_word_array p4 in
let np5 = to_word_array p5 in
let r = glGetActiveVaryingNV p0 p1 p2 np3 np4 np5 p6 in
let _ = copy_word_array np3 p3 in
let _ = copy_word_array np4 p4 in
let _ = copy_word_array np5 p5 in
r


external glGetArrayObjectfvATI: int -> int -> float_array -> unit = "glstub_glGetArrayObjectfvATI" "glstub_glGetArrayObjectfvATI"
let glGetArrayObjectfvATI p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetArrayObjectfvATI p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetArrayObjectivATI: int -> int -> word_array -> unit = "glstub_glGetArrayObjectivATI" "glstub_glGetArrayObjectivATI"
let glGetArrayObjectivATI p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetArrayObjectivATI p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetAttachedObjectsARB: int -> int -> word_array -> word_array -> unit = "glstub_glGetAttachedObjectsARB" "glstub_glGetAttachedObjectsARB"
let glGetAttachedObjectsARB p0 p1 p2 p3 =
let np2 = to_word_array p2 in
let np3 = to_word_array p3 in
let r = glGetAttachedObjectsARB p0 p1 np2 np3 in
let _ = copy_word_array np2 p2 in
let _ = copy_word_array np3 p3 in
r


external glGetAttachedShaders: int -> int -> word_array -> word_array -> unit = "glstub_glGetAttachedShaders" "glstub_glGetAttachedShaders"
let glGetAttachedShaders p0 p1 p2 p3 =
let np2 = to_word_array p2 in
let np3 = to_word_array p3 in
let r = glGetAttachedShaders p0 p1 np2 np3 in
let _ = copy_word_array np2 p2 in
let _ = copy_word_array np3 p3 in
r

external glGetAttribLocation: int -> string -> int = "glstub_glGetAttribLocation" "glstub_glGetAttribLocation"
external glGetAttribLocationARB: int -> string -> int = "glstub_glGetAttribLocationARB" "glstub_glGetAttribLocationARB"

external glGetBooleanIndexedvEXT: int -> int -> word_array -> unit = "glstub_glGetBooleanIndexedvEXT" "glstub_glGetBooleanIndexedvEXT"
let glGetBooleanIndexedvEXT p0 p1 p2 =
let np2 = to_word_array (bool_to_int_array p2) in
let r = glGetBooleanIndexedvEXT p0 p1 np2 in
let bp2 =  Array.create (Bigarray.Array1.dim np2) 0 in
let _ = copy_word_array np2 bp2 in
let _ = copy_to_bool_array bp2 p2 in
r


external glGetBooleanv: int -> word_array -> unit = "glstub_glGetBooleanv" "glstub_glGetBooleanv"
let glGetBooleanv p0 p1 =
let np1 = to_word_array (bool_to_int_array p1) in
let r = glGetBooleanv p0 np1 in
let bp1 =  Array.create (Bigarray.Array1.dim np1) 0 in
let _ = copy_word_array np1 bp1 in
let _ = copy_to_bool_array bp1 p1 in
r


external glGetBufferParameteriv: int -> int -> word_array -> unit = "glstub_glGetBufferParameteriv" "glstub_glGetBufferParameteriv"
let glGetBufferParameteriv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetBufferParameteriv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetBufferParameterivARB: int -> int -> word_array -> unit = "glstub_glGetBufferParameterivARB" "glstub_glGetBufferParameterivARB"
let glGetBufferParameterivARB p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetBufferParameterivARB p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glGetBufferPointerv: int -> int -> 'a -> unit = "glstub_glGetBufferPointerv" "glstub_glGetBufferPointerv"
external glGetBufferPointervARB: int -> int -> 'a -> unit = "glstub_glGetBufferPointervARB" "glstub_glGetBufferPointervARB"
external glGetBufferSubData: int -> int -> int -> 'a -> unit = "glstub_glGetBufferSubData" "glstub_glGetBufferSubData"
external glGetBufferSubDataARB: int -> int -> int -> 'a -> unit = "glstub_glGetBufferSubDataARB" "glstub_glGetBufferSubDataARB"
external glGetClipPlane: int -> float array -> unit = "glstub_glGetClipPlane" "glstub_glGetClipPlane"

external glGetClipPlanefOES: int -> float_array -> unit = "glstub_glGetClipPlanefOES" "glstub_glGetClipPlanefOES"
let glGetClipPlanefOES p0 p1 =
let np1 = to_float_array p1 in
let r = glGetClipPlanefOES p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glGetColorTable: int -> int -> int -> 'a -> unit = "glstub_glGetColorTable" "glstub_glGetColorTable"
external glGetColorTableEXT: int -> int -> int -> 'a -> unit = "glstub_glGetColorTableEXT" "glstub_glGetColorTableEXT"

external glGetColorTableParameterfv: int -> int -> float_array -> unit = "glstub_glGetColorTableParameterfv" "glstub_glGetColorTableParameterfv"
let glGetColorTableParameterfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetColorTableParameterfv p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetColorTableParameterfvEXT: int -> int -> float_array -> unit = "glstub_glGetColorTableParameterfvEXT" "glstub_glGetColorTableParameterfvEXT"
let glGetColorTableParameterfvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetColorTableParameterfvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetColorTableParameterfvSGI: int -> int -> float_array -> unit = "glstub_glGetColorTableParameterfvSGI" "glstub_glGetColorTableParameterfvSGI"
let glGetColorTableParameterfvSGI p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetColorTableParameterfvSGI p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetColorTableParameteriv: int -> int -> word_array -> unit = "glstub_glGetColorTableParameteriv" "glstub_glGetColorTableParameteriv"
let glGetColorTableParameteriv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetColorTableParameteriv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetColorTableParameterivEXT: int -> int -> word_array -> unit = "glstub_glGetColorTableParameterivEXT" "glstub_glGetColorTableParameterivEXT"
let glGetColorTableParameterivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetColorTableParameterivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetColorTableParameterivSGI: int -> int -> word_array -> unit = "glstub_glGetColorTableParameterivSGI" "glstub_glGetColorTableParameterivSGI"
let glGetColorTableParameterivSGI p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetColorTableParameterivSGI p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glGetColorTableSGI: int -> int -> int -> 'a -> unit = "glstub_glGetColorTableSGI" "glstub_glGetColorTableSGI"

external glGetCombinerInputParameterfvNV: int -> int -> int -> int -> float_array -> unit = "glstub_glGetCombinerInputParameterfvNV" "glstub_glGetCombinerInputParameterfvNV"
let glGetCombinerInputParameterfvNV p0 p1 p2 p3 p4 =
let np4 = to_float_array p4 in
let r = glGetCombinerInputParameterfvNV p0 p1 p2 p3 np4 in
let _ = copy_float_array np4 p4 in
r


external glGetCombinerInputParameterivNV: int -> int -> int -> int -> word_array -> unit = "glstub_glGetCombinerInputParameterivNV" "glstub_glGetCombinerInputParameterivNV"
let glGetCombinerInputParameterivNV p0 p1 p2 p3 p4 =
let np4 = to_word_array p4 in
let r = glGetCombinerInputParameterivNV p0 p1 p2 p3 np4 in
let _ = copy_word_array np4 p4 in
r


external glGetCombinerOutputParameterfvNV: int -> int -> int -> float_array -> unit = "glstub_glGetCombinerOutputParameterfvNV" "glstub_glGetCombinerOutputParameterfvNV"
let glGetCombinerOutputParameterfvNV p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glGetCombinerOutputParameterfvNV p0 p1 p2 np3 in
let _ = copy_float_array np3 p3 in
r


external glGetCombinerOutputParameterivNV: int -> int -> int -> word_array -> unit = "glstub_glGetCombinerOutputParameterivNV" "glstub_glGetCombinerOutputParameterivNV"
let glGetCombinerOutputParameterivNV p0 p1 p2 p3 =
let np3 = to_word_array p3 in
let r = glGetCombinerOutputParameterivNV p0 p1 p2 np3 in
let _ = copy_word_array np3 p3 in
r


external glGetCombinerStageParameterfvNV: int -> int -> float_array -> unit = "glstub_glGetCombinerStageParameterfvNV" "glstub_glGetCombinerStageParameterfvNV"
let glGetCombinerStageParameterfvNV p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetCombinerStageParameterfvNV p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glGetCompressedTexImage: int -> int -> 'a -> unit = "glstub_glGetCompressedTexImage" "glstub_glGetCompressedTexImage"
external glGetCompressedTexImageARB: int -> int -> 'a -> unit = "glstub_glGetCompressedTexImageARB" "glstub_glGetCompressedTexImageARB"
external glGetConvolutionFilter: int -> int -> int -> 'a -> unit = "glstub_glGetConvolutionFilter" "glstub_glGetConvolutionFilter"
external glGetConvolutionFilterEXT: int -> int -> int -> 'a -> unit = "glstub_glGetConvolutionFilterEXT" "glstub_glGetConvolutionFilterEXT"

external glGetConvolutionParameterfv: int -> int -> float_array -> unit = "glstub_glGetConvolutionParameterfv" "glstub_glGetConvolutionParameterfv"
let glGetConvolutionParameterfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetConvolutionParameterfv p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetConvolutionParameterfvEXT: int -> int -> float_array -> unit = "glstub_glGetConvolutionParameterfvEXT" "glstub_glGetConvolutionParameterfvEXT"
let glGetConvolutionParameterfvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetConvolutionParameterfvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetConvolutionParameteriv: int -> int -> word_array -> unit = "glstub_glGetConvolutionParameteriv" "glstub_glGetConvolutionParameteriv"
let glGetConvolutionParameteriv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetConvolutionParameteriv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetConvolutionParameterivEXT: int -> int -> word_array -> unit = "glstub_glGetConvolutionParameterivEXT" "glstub_glGetConvolutionParameterivEXT"
let glGetConvolutionParameterivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetConvolutionParameterivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetDetailTexFuncSGIS: int -> float_array -> unit = "glstub_glGetDetailTexFuncSGIS" "glstub_glGetDetailTexFuncSGIS"
let glGetDetailTexFuncSGIS p0 p1 =
let np1 = to_float_array p1 in
let r = glGetDetailTexFuncSGIS p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glGetDoublev: int -> float array -> unit = "glstub_glGetDoublev" "glstub_glGetDoublev"
external glGetError: unit -> int = "glstub_glGetError" "glstub_glGetError"

external glGetFenceivNV: int -> int -> word_array -> unit = "glstub_glGetFenceivNV" "glstub_glGetFenceivNV"
let glGetFenceivNV p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetFenceivNV p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetFinalCombinerInputParameterfvNV: int -> int -> float_array -> unit = "glstub_glGetFinalCombinerInputParameterfvNV" "glstub_glGetFinalCombinerInputParameterfvNV"
let glGetFinalCombinerInputParameterfvNV p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetFinalCombinerInputParameterfvNV p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetFinalCombinerInputParameterivNV: int -> int -> word_array -> unit = "glstub_glGetFinalCombinerInputParameterivNV" "glstub_glGetFinalCombinerInputParameterivNV"
let glGetFinalCombinerInputParameterivNV p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetFinalCombinerInputParameterivNV p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetFloatv: int -> float_array -> unit = "glstub_glGetFloatv" "glstub_glGetFloatv"
let glGetFloatv p0 p1 =
let np1 = to_float_array p1 in
let r = glGetFloatv p0 np1 in
let _ = copy_float_array np1 p1 in
r


external glGetFogFuncSGIS: float_array -> unit = "glstub_glGetFogFuncSGIS" "glstub_glGetFogFuncSGIS"
let glGetFogFuncSGIS p0 =
let np0 = to_float_array p0 in
let r = glGetFogFuncSGIS np0 in
let _ = copy_float_array np0 p0 in
r

external glGetFragDataLocationEXT: int -> string -> int = "glstub_glGetFragDataLocationEXT" "glstub_glGetFragDataLocationEXT"

external glGetFragmentLightfvEXT: int -> int -> float_array -> unit = "glstub_glGetFragmentLightfvEXT" "glstub_glGetFragmentLightfvEXT"
let glGetFragmentLightfvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetFragmentLightfvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetFragmentLightfvSGIX: int -> int -> float_array -> unit = "glstub_glGetFragmentLightfvSGIX" "glstub_glGetFragmentLightfvSGIX"
let glGetFragmentLightfvSGIX p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetFragmentLightfvSGIX p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetFragmentLightivEXT: int -> int -> word_array -> unit = "glstub_glGetFragmentLightivEXT" "glstub_glGetFragmentLightivEXT"
let glGetFragmentLightivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetFragmentLightivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetFragmentLightivSGIX: int -> int -> word_array -> unit = "glstub_glGetFragmentLightivSGIX" "glstub_glGetFragmentLightivSGIX"
let glGetFragmentLightivSGIX p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetFragmentLightivSGIX p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetFragmentMaterialfvEXT: int -> int -> float_array -> unit = "glstub_glGetFragmentMaterialfvEXT" "glstub_glGetFragmentMaterialfvEXT"
let glGetFragmentMaterialfvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetFragmentMaterialfvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetFragmentMaterialfvSGIX: int -> int -> float_array -> unit = "glstub_glGetFragmentMaterialfvSGIX" "glstub_glGetFragmentMaterialfvSGIX"
let glGetFragmentMaterialfvSGIX p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetFragmentMaterialfvSGIX p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetFragmentMaterialivEXT: int -> int -> word_array -> unit = "glstub_glGetFragmentMaterialivEXT" "glstub_glGetFragmentMaterialivEXT"
let glGetFragmentMaterialivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetFragmentMaterialivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetFragmentMaterialivSGIX: int -> int -> word_array -> unit = "glstub_glGetFragmentMaterialivSGIX" "glstub_glGetFragmentMaterialivSGIX"
let glGetFragmentMaterialivSGIX p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetFragmentMaterialivSGIX p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetFramebufferAttachmentParameterivEXT: int -> int -> int -> word_array -> unit = "glstub_glGetFramebufferAttachmentParameterivEXT" "glstub_glGetFramebufferAttachmentParameterivEXT"
let glGetFramebufferAttachmentParameterivEXT p0 p1 p2 p3 =
let np3 = to_word_array p3 in
let r = glGetFramebufferAttachmentParameterivEXT p0 p1 p2 np3 in
let _ = copy_word_array np3 p3 in
r

external glGetHandleARB: int -> int = "glstub_glGetHandleARB" "glstub_glGetHandleARB"
external glGetHistogram: int -> bool -> int -> int -> 'a -> unit = "glstub_glGetHistogram" "glstub_glGetHistogram"
external glGetHistogramEXT: int -> bool -> int -> int -> 'a -> unit = "glstub_glGetHistogramEXT" "glstub_glGetHistogramEXT"

external glGetHistogramParameterfv: int -> int -> float_array -> unit = "glstub_glGetHistogramParameterfv" "glstub_glGetHistogramParameterfv"
let glGetHistogramParameterfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetHistogramParameterfv p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetHistogramParameterfvEXT: int -> int -> float_array -> unit = "glstub_glGetHistogramParameterfvEXT" "glstub_glGetHistogramParameterfvEXT"
let glGetHistogramParameterfvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetHistogramParameterfvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetHistogramParameteriv: int -> int -> word_array -> unit = "glstub_glGetHistogramParameteriv" "glstub_glGetHistogramParameteriv"
let glGetHistogramParameteriv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetHistogramParameteriv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetHistogramParameterivEXT: int -> int -> word_array -> unit = "glstub_glGetHistogramParameterivEXT" "glstub_glGetHistogramParameterivEXT"
let glGetHistogramParameterivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetHistogramParameterivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetImageTransformParameterfvHP: int -> int -> float_array -> unit = "glstub_glGetImageTransformParameterfvHP" "glstub_glGetImageTransformParameterfvHP"
let glGetImageTransformParameterfvHP p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetImageTransformParameterfvHP p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetImageTransformParameterivHP: int -> int -> word_array -> unit = "glstub_glGetImageTransformParameterivHP" "glstub_glGetImageTransformParameterivHP"
let glGetImageTransformParameterivHP p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetImageTransformParameterivHP p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetInfoLogARB: int -> int -> word_array -> string -> unit = "glstub_glGetInfoLogARB" "glstub_glGetInfoLogARB"
let glGetInfoLogARB p0 p1 p2 p3 =
let np2 = to_word_array p2 in
let r = glGetInfoLogARB p0 p1 np2 p3 in
let _ = copy_word_array np2 p2 in
r


external glGetIntegerIndexedvEXT: int -> int -> word_array -> unit = "glstub_glGetIntegerIndexedvEXT" "glstub_glGetIntegerIndexedvEXT"
let glGetIntegerIndexedvEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetIntegerIndexedvEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetIntegerv: int -> word_array -> unit = "glstub_glGetIntegerv" "glstub_glGetIntegerv"
let glGetIntegerv p0 p1 =
let np1 = to_word_array p1 in
let r = glGetIntegerv p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glGetInvariantBooleanvEXT: int -> int -> word_array -> unit = "glstub_glGetInvariantBooleanvEXT" "glstub_glGetInvariantBooleanvEXT"
let glGetInvariantBooleanvEXT p0 p1 p2 =
let np2 = to_word_array (bool_to_int_array p2) in
let r = glGetInvariantBooleanvEXT p0 p1 np2 in
let bp2 =  Array.create (Bigarray.Array1.dim np2) 0 in
let _ = copy_word_array np2 bp2 in
let _ = copy_to_bool_array bp2 p2 in
r


external glGetInvariantFloatvEXT: int -> int -> float_array -> unit = "glstub_glGetInvariantFloatvEXT" "glstub_glGetInvariantFloatvEXT"
let glGetInvariantFloatvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetInvariantFloatvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetInvariantIntegervEXT: int -> int -> word_array -> unit = "glstub_glGetInvariantIntegervEXT" "glstub_glGetInvariantIntegervEXT"
let glGetInvariantIntegervEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetInvariantIntegervEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetLightfv: int -> int -> float_array -> unit = "glstub_glGetLightfv" "glstub_glGetLightfv"
let glGetLightfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetLightfv p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetLightiv: int -> int -> word_array -> unit = "glstub_glGetLightiv" "glstub_glGetLightiv"
let glGetLightiv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetLightiv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetLocalConstantBooleanvEXT: int -> int -> word_array -> unit = "glstub_glGetLocalConstantBooleanvEXT" "glstub_glGetLocalConstantBooleanvEXT"
let glGetLocalConstantBooleanvEXT p0 p1 p2 =
let np2 = to_word_array (bool_to_int_array p2) in
let r = glGetLocalConstantBooleanvEXT p0 p1 np2 in
let bp2 =  Array.create (Bigarray.Array1.dim np2) 0 in
let _ = copy_word_array np2 bp2 in
let _ = copy_to_bool_array bp2 p2 in
r


external glGetLocalConstantFloatvEXT: int -> int -> float_array -> unit = "glstub_glGetLocalConstantFloatvEXT" "glstub_glGetLocalConstantFloatvEXT"
let glGetLocalConstantFloatvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetLocalConstantFloatvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetLocalConstantIntegervEXT: int -> int -> word_array -> unit = "glstub_glGetLocalConstantIntegervEXT" "glstub_glGetLocalConstantIntegervEXT"
let glGetLocalConstantIntegervEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetLocalConstantIntegervEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetMapAttribParameterfvNV: int -> int -> int -> float_array -> unit = "glstub_glGetMapAttribParameterfvNV" "glstub_glGetMapAttribParameterfvNV"
let glGetMapAttribParameterfvNV p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glGetMapAttribParameterfvNV p0 p1 p2 np3 in
let _ = copy_float_array np3 p3 in
r


external glGetMapAttribParameterivNV: int -> int -> int -> word_array -> unit = "glstub_glGetMapAttribParameterivNV" "glstub_glGetMapAttribParameterivNV"
let glGetMapAttribParameterivNV p0 p1 p2 p3 =
let np3 = to_word_array p3 in
let r = glGetMapAttribParameterivNV p0 p1 p2 np3 in
let _ = copy_word_array np3 p3 in
r

external glGetMapControlPointsNV: int -> int -> int -> int -> int -> bool -> 'a -> unit = "glstub_glGetMapControlPointsNV_byte" "glstub_glGetMapControlPointsNV"

external glGetMapParameterfvNV: int -> int -> float_array -> unit = "glstub_glGetMapParameterfvNV" "glstub_glGetMapParameterfvNV"
let glGetMapParameterfvNV p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetMapParameterfvNV p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetMapParameterivNV: int -> int -> word_array -> unit = "glstub_glGetMapParameterivNV" "glstub_glGetMapParameterivNV"
let glGetMapParameterivNV p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetMapParameterivNV p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glGetMapdv: int -> int -> float array -> unit = "glstub_glGetMapdv" "glstub_glGetMapdv"

external glGetMapfv: int -> int -> float_array -> unit = "glstub_glGetMapfv" "glstub_glGetMapfv"
let glGetMapfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetMapfv p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetMapiv: int -> int -> word_array -> unit = "glstub_glGetMapiv" "glstub_glGetMapiv"
let glGetMapiv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetMapiv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetMaterialfv: int -> int -> float_array -> unit = "glstub_glGetMaterialfv" "glstub_glGetMaterialfv"
let glGetMaterialfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetMaterialfv p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetMaterialiv: int -> int -> word_array -> unit = "glstub_glGetMaterialiv" "glstub_glGetMaterialiv"
let glGetMaterialiv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetMaterialiv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glGetMinmax: int -> bool -> int -> int -> 'a -> unit = "glstub_glGetMinmax" "glstub_glGetMinmax"
external glGetMinmaxEXT: int -> bool -> int -> int -> 'a -> unit = "glstub_glGetMinmaxEXT" "glstub_glGetMinmaxEXT"

external glGetMinmaxParameterfv: int -> int -> float_array -> unit = "glstub_glGetMinmaxParameterfv" "glstub_glGetMinmaxParameterfv"
let glGetMinmaxParameterfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetMinmaxParameterfv p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetMinmaxParameterfvEXT: int -> int -> float_array -> unit = "glstub_glGetMinmaxParameterfvEXT" "glstub_glGetMinmaxParameterfvEXT"
let glGetMinmaxParameterfvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetMinmaxParameterfvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetMinmaxParameteriv: int -> int -> word_array -> unit = "glstub_glGetMinmaxParameteriv" "glstub_glGetMinmaxParameteriv"
let glGetMinmaxParameteriv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetMinmaxParameteriv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetMinmaxParameterivEXT: int -> int -> word_array -> unit = "glstub_glGetMinmaxParameterivEXT" "glstub_glGetMinmaxParameterivEXT"
let glGetMinmaxParameterivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetMinmaxParameterivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetObjectBufferfvATI: int -> int -> float_array -> unit = "glstub_glGetObjectBufferfvATI" "glstub_glGetObjectBufferfvATI"
let glGetObjectBufferfvATI p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetObjectBufferfvATI p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetObjectBufferivATI: int -> int -> word_array -> unit = "glstub_glGetObjectBufferivATI" "glstub_glGetObjectBufferivATI"
let glGetObjectBufferivATI p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetObjectBufferivATI p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetObjectParameterfvARB: int -> int -> float_array -> unit = "glstub_glGetObjectParameterfvARB" "glstub_glGetObjectParameterfvARB"
let glGetObjectParameterfvARB p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetObjectParameterfvARB p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetObjectParameterivARB: int -> int -> word_array -> unit = "glstub_glGetObjectParameterivARB" "glstub_glGetObjectParameterivARB"
let glGetObjectParameterivARB p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetObjectParameterivARB p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetOcclusionQueryivNV: int -> int -> word_array -> unit = "glstub_glGetOcclusionQueryivNV" "glstub_glGetOcclusionQueryivNV"
let glGetOcclusionQueryivNV p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetOcclusionQueryivNV p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetOcclusionQueryuivNV: int -> int -> word_array -> unit = "glstub_glGetOcclusionQueryuivNV" "glstub_glGetOcclusionQueryuivNV"
let glGetOcclusionQueryuivNV p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetOcclusionQueryuivNV p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetPixelMapfv: int -> float_array -> unit = "glstub_glGetPixelMapfv" "glstub_glGetPixelMapfv"
let glGetPixelMapfv p0 p1 =
let np1 = to_float_array p1 in
let r = glGetPixelMapfv p0 np1 in
let _ = copy_float_array np1 p1 in
r


external glGetPixelMapuiv: int -> word_array -> unit = "glstub_glGetPixelMapuiv" "glstub_glGetPixelMapuiv"
let glGetPixelMapuiv p0 p1 =
let np1 = to_word_array p1 in
let r = glGetPixelMapuiv p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glGetPixelMapusv: int -> ushort_array -> unit = "glstub_glGetPixelMapusv" "glstub_glGetPixelMapusv"
let glGetPixelMapusv p0 p1 =
let np1 = to_ushort_array p1 in
let r = glGetPixelMapusv p0 np1 in
let _ = copy_ushort_array np1 p1 in
r


external glGetPixelTransformParameterfvEXT: int -> int -> float_array -> unit = "glstub_glGetPixelTransformParameterfvEXT" "glstub_glGetPixelTransformParameterfvEXT"
let glGetPixelTransformParameterfvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetPixelTransformParameterfvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetPixelTransformParameterivEXT: int -> int -> word_array -> unit = "glstub_glGetPixelTransformParameterivEXT" "glstub_glGetPixelTransformParameterivEXT"
let glGetPixelTransformParameterivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetPixelTransformParameterivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glGetPointerv: int -> 'a -> unit = "glstub_glGetPointerv" "glstub_glGetPointerv"
external glGetPointervEXT: int -> 'a -> unit = "glstub_glGetPointervEXT" "glstub_glGetPointervEXT"

external glGetPolygonStipple: ubyte_array -> unit = "glstub_glGetPolygonStipple" "glstub_glGetPolygonStipple"
let glGetPolygonStipple p0 =
let np0 = to_ubyte_array p0 in
let r = glGetPolygonStipple np0 in
let _ = copy_ubyte_array np0 p0 in
r

external glGetProgramEnvParameterdvARB: int -> int -> float array -> unit = "glstub_glGetProgramEnvParameterdvARB" "glstub_glGetProgramEnvParameterdvARB"

external glGetProgramEnvParameterfvARB: int -> int -> float_array -> unit = "glstub_glGetProgramEnvParameterfvARB" "glstub_glGetProgramEnvParameterfvARB"
let glGetProgramEnvParameterfvARB p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetProgramEnvParameterfvARB p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetProgramInfoLog: int -> int -> word_array -> string -> unit = "glstub_glGetProgramInfoLog" "glstub_glGetProgramInfoLog"
let glGetProgramInfoLog p0 p1 p2 p3 =
let np2 = to_word_array p2 in
let r = glGetProgramInfoLog p0 p1 np2 p3 in
let _ = copy_word_array np2 p2 in
r

external glGetProgramLocalParameterdvARB: int -> int -> float array -> unit = "glstub_glGetProgramLocalParameterdvARB" "glstub_glGetProgramLocalParameterdvARB"

external glGetProgramLocalParameterfvARB: int -> int -> float_array -> unit = "glstub_glGetProgramLocalParameterfvARB" "glstub_glGetProgramLocalParameterfvARB"
let glGetProgramLocalParameterfvARB p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetProgramLocalParameterfvARB p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetProgramNamedParameterdvNV: int -> int -> ubyte_array -> float array -> unit = "glstub_glGetProgramNamedParameterdvNV" "glstub_glGetProgramNamedParameterdvNV"
let glGetProgramNamedParameterdvNV p0 p1 p2 p3 =
let np2 = to_ubyte_array p2 in
let r = glGetProgramNamedParameterdvNV p0 p1 np2 p3 in
let _ = copy_ubyte_array np2 p2 in
r


external glGetProgramNamedParameterfvNV: int -> int -> ubyte_array -> float_array -> unit = "glstub_glGetProgramNamedParameterfvNV" "glstub_glGetProgramNamedParameterfvNV"
let glGetProgramNamedParameterfvNV p0 p1 p2 p3 =
let np2 = to_ubyte_array p2 in
let np3 = to_float_array p3 in
let r = glGetProgramNamedParameterfvNV p0 p1 np2 np3 in
let _ = copy_ubyte_array np2 p2 in
let _ = copy_float_array np3 p3 in
r

external glGetProgramParameterdvNV: int -> int -> int -> float array -> unit = "glstub_glGetProgramParameterdvNV" "glstub_glGetProgramParameterdvNV"

external glGetProgramParameterfvNV: int -> int -> int -> float_array -> unit = "glstub_glGetProgramParameterfvNV" "glstub_glGetProgramParameterfvNV"
let glGetProgramParameterfvNV p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glGetProgramParameterfvNV p0 p1 p2 np3 in
let _ = copy_float_array np3 p3 in
r

external glGetProgramStringARB: int -> int -> 'a -> unit = "glstub_glGetProgramStringARB" "glstub_glGetProgramStringARB"

external glGetProgramStringNV: int -> int -> ubyte_array -> unit = "glstub_glGetProgramStringNV" "glstub_glGetProgramStringNV"
let glGetProgramStringNV p0 p1 p2 =
let np2 = to_ubyte_array p2 in
let r = glGetProgramStringNV p0 p1 np2 in
let _ = copy_ubyte_array np2 p2 in
r


external glGetProgramiv: int -> int -> word_array -> unit = "glstub_glGetProgramiv" "glstub_glGetProgramiv"
let glGetProgramiv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetProgramiv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetProgramivARB: int -> int -> word_array -> unit = "glstub_glGetProgramivARB" "glstub_glGetProgramivARB"
let glGetProgramivARB p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetProgramivARB p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetProgramivNV: int -> int -> word_array -> unit = "glstub_glGetProgramivNV" "glstub_glGetProgramivNV"
let glGetProgramivNV p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetProgramivNV p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetQueryObjectiv: int -> int -> word_array -> unit = "glstub_glGetQueryObjectiv" "glstub_glGetQueryObjectiv"
let glGetQueryObjectiv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetQueryObjectiv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetQueryObjectivARB: int -> int -> word_array -> unit = "glstub_glGetQueryObjectivARB" "glstub_glGetQueryObjectivARB"
let glGetQueryObjectivARB p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetQueryObjectivARB p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetQueryObjectuiv: int -> int -> word_array -> unit = "glstub_glGetQueryObjectuiv" "glstub_glGetQueryObjectuiv"
let glGetQueryObjectuiv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetQueryObjectuiv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetQueryObjectuivARB: int -> int -> word_array -> unit = "glstub_glGetQueryObjectuivARB" "glstub_glGetQueryObjectuivARB"
let glGetQueryObjectuivARB p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetQueryObjectuivARB p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetQueryiv: int -> int -> word_array -> unit = "glstub_glGetQueryiv" "glstub_glGetQueryiv"
let glGetQueryiv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetQueryiv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetQueryivARB: int -> int -> word_array -> unit = "glstub_glGetQueryivARB" "glstub_glGetQueryivARB"
let glGetQueryivARB p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetQueryivARB p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetRenderbufferParameterivEXT: int -> int -> word_array -> unit = "glstub_glGetRenderbufferParameterivEXT" "glstub_glGetRenderbufferParameterivEXT"
let glGetRenderbufferParameterivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetRenderbufferParameterivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glGetSeparableFilter: int -> int -> int -> 'a -> 'a -> 'a -> unit = "glstub_glGetSeparableFilter_byte" "glstub_glGetSeparableFilter"
external glGetSeparableFilterEXT: int -> int -> int -> 'a -> 'a -> 'a -> unit = "glstub_glGetSeparableFilterEXT_byte" "glstub_glGetSeparableFilterEXT"

external glGetShaderInfoLog: int -> int -> word_array -> string -> unit = "glstub_glGetShaderInfoLog" "glstub_glGetShaderInfoLog"
let glGetShaderInfoLog p0 p1 p2 p3 =
let np2 = to_word_array p2 in
let r = glGetShaderInfoLog p0 p1 np2 p3 in
let _ = copy_word_array np2 p2 in
r


external glGetShaderSource: int -> int -> word_array -> string -> unit = "glstub_glGetShaderSource" "glstub_glGetShaderSource"
let glGetShaderSource p0 p1 p2 p3 =
let np2 = to_word_array p2 in
let r = glGetShaderSource p0 p1 np2 p3 in
let _ = copy_word_array np2 p2 in
r


external glGetShaderSourceARB: int -> int -> word_array -> string -> unit = "glstub_glGetShaderSourceARB" "glstub_glGetShaderSourceARB"
let glGetShaderSourceARB p0 p1 p2 p3 =
let np2 = to_word_array p2 in
let r = glGetShaderSourceARB p0 p1 np2 p3 in
let _ = copy_word_array np2 p2 in
r


external glGetShaderiv: int -> int -> word_array -> unit = "glstub_glGetShaderiv" "glstub_glGetShaderiv"
let glGetShaderiv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetShaderiv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetSharpenTexFuncSGIS: int -> float_array -> unit = "glstub_glGetSharpenTexFuncSGIS" "glstub_glGetSharpenTexFuncSGIS"
let glGetSharpenTexFuncSGIS p0 p1 =
let np1 = to_float_array p1 in
let r = glGetSharpenTexFuncSGIS p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glGetString: int -> string = "glstub_glGetString" "glstub_glGetString"

external glGetTexBumpParameterfvATI: int -> float_array -> unit = "glstub_glGetTexBumpParameterfvATI" "glstub_glGetTexBumpParameterfvATI"
let glGetTexBumpParameterfvATI p0 p1 =
let np1 = to_float_array p1 in
let r = glGetTexBumpParameterfvATI p0 np1 in
let _ = copy_float_array np1 p1 in
r


external glGetTexBumpParameterivATI: int -> word_array -> unit = "glstub_glGetTexBumpParameterivATI" "glstub_glGetTexBumpParameterivATI"
let glGetTexBumpParameterivATI p0 p1 =
let np1 = to_word_array p1 in
let r = glGetTexBumpParameterivATI p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glGetTexEnvfv: int -> int -> float_array -> unit = "glstub_glGetTexEnvfv" "glstub_glGetTexEnvfv"
let glGetTexEnvfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetTexEnvfv p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetTexEnviv: int -> int -> word_array -> unit = "glstub_glGetTexEnviv" "glstub_glGetTexEnviv"
let glGetTexEnviv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetTexEnviv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetTexFilterFuncSGIS: int -> int -> float_array -> unit = "glstub_glGetTexFilterFuncSGIS" "glstub_glGetTexFilterFuncSGIS"
let glGetTexFilterFuncSGIS p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetTexFilterFuncSGIS p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glGetTexGendv: int -> int -> float array -> unit = "glstub_glGetTexGendv" "glstub_glGetTexGendv"

external glGetTexGenfv: int -> int -> float_array -> unit = "glstub_glGetTexGenfv" "glstub_glGetTexGenfv"
let glGetTexGenfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetTexGenfv p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetTexGeniv: int -> int -> word_array -> unit = "glstub_glGetTexGeniv" "glstub_glGetTexGeniv"
let glGetTexGeniv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetTexGeniv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glGetTexImage: int -> int -> int -> int -> 'a -> unit = "glstub_glGetTexImage" "glstub_glGetTexImage"

external glGetTexLevelParameterfv: int -> int -> int -> float_array -> unit = "glstub_glGetTexLevelParameterfv" "glstub_glGetTexLevelParameterfv"
let glGetTexLevelParameterfv p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glGetTexLevelParameterfv p0 p1 p2 np3 in
let _ = copy_float_array np3 p3 in
r


external glGetTexLevelParameteriv: int -> int -> int -> word_array -> unit = "glstub_glGetTexLevelParameteriv" "glstub_glGetTexLevelParameteriv"
let glGetTexLevelParameteriv p0 p1 p2 p3 =
let np3 = to_word_array p3 in
let r = glGetTexLevelParameteriv p0 p1 p2 np3 in
let _ = copy_word_array np3 p3 in
r


external glGetTexParameterIivEXT: int -> int -> word_array -> unit = "glstub_glGetTexParameterIivEXT" "glstub_glGetTexParameterIivEXT"
let glGetTexParameterIivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetTexParameterIivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetTexParameterIuivEXT: int -> int -> word_array -> unit = "glstub_glGetTexParameterIuivEXT" "glstub_glGetTexParameterIuivEXT"
let glGetTexParameterIuivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetTexParameterIuivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glGetTexParameterPointervAPPLE: int -> int -> 'a -> unit = "glstub_glGetTexParameterPointervAPPLE" "glstub_glGetTexParameterPointervAPPLE"

external glGetTexParameterfv: int -> int -> float_array -> unit = "glstub_glGetTexParameterfv" "glstub_glGetTexParameterfv"
let glGetTexParameterfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetTexParameterfv p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetTexParameteriv: int -> int -> word_array -> unit = "glstub_glGetTexParameteriv" "glstub_glGetTexParameteriv"
let glGetTexParameteriv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetTexParameteriv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetTrackMatrixivNV: int -> int -> int -> word_array -> unit = "glstub_glGetTrackMatrixivNV" "glstub_glGetTrackMatrixivNV"
let glGetTrackMatrixivNV p0 p1 p2 p3 =
let np3 = to_word_array p3 in
let r = glGetTrackMatrixivNV p0 p1 p2 np3 in
let _ = copy_word_array np3 p3 in
r


external glGetTransformFeedbackVaryingNV: int -> int -> word_array -> unit = "glstub_glGetTransformFeedbackVaryingNV" "glstub_glGetTransformFeedbackVaryingNV"
let glGetTransformFeedbackVaryingNV p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetTransformFeedbackVaryingNV p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glGetUniformBufferSizeEXT: int -> int -> int = "glstub_glGetUniformBufferSizeEXT" "glstub_glGetUniformBufferSizeEXT"
external glGetUniformLocation: int -> string -> int = "glstub_glGetUniformLocation" "glstub_glGetUniformLocation"
external glGetUniformLocationARB: int -> string -> int = "glstub_glGetUniformLocationARB" "glstub_glGetUniformLocationARB"
external glGetUniformOffsetEXT: int -> int -> int = "glstub_glGetUniformOffsetEXT" "glstub_glGetUniformOffsetEXT"

external glGetUniformfv: int -> int -> float_array -> unit = "glstub_glGetUniformfv" "glstub_glGetUniformfv"
let glGetUniformfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetUniformfv p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetUniformfvARB: int -> int -> float_array -> unit = "glstub_glGetUniformfvARB" "glstub_glGetUniformfvARB"
let glGetUniformfvARB p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetUniformfvARB p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetUniformiv: int -> int -> word_array -> unit = "glstub_glGetUniformiv" "glstub_glGetUniformiv"
let glGetUniformiv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetUniformiv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetUniformivARB: int -> int -> word_array -> unit = "glstub_glGetUniformivARB" "glstub_glGetUniformivARB"
let glGetUniformivARB p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetUniformivARB p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetUniformuivEXT: int -> int -> word_array -> unit = "glstub_glGetUniformuivEXT" "glstub_glGetUniformuivEXT"
let glGetUniformuivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetUniformuivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetVariantArrayObjectfvATI: int -> int -> float_array -> unit = "glstub_glGetVariantArrayObjectfvATI" "glstub_glGetVariantArrayObjectfvATI"
let glGetVariantArrayObjectfvATI p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetVariantArrayObjectfvATI p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetVariantArrayObjectivATI: int -> int -> word_array -> unit = "glstub_glGetVariantArrayObjectivATI" "glstub_glGetVariantArrayObjectivATI"
let glGetVariantArrayObjectivATI p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetVariantArrayObjectivATI p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetVariantBooleanvEXT: int -> int -> word_array -> unit = "glstub_glGetVariantBooleanvEXT" "glstub_glGetVariantBooleanvEXT"
let glGetVariantBooleanvEXT p0 p1 p2 =
let np2 = to_word_array (bool_to_int_array p2) in
let r = glGetVariantBooleanvEXT p0 p1 np2 in
let bp2 =  Array.create (Bigarray.Array1.dim np2) 0 in
let _ = copy_word_array np2 bp2 in
let _ = copy_to_bool_array bp2 p2 in
r


external glGetVariantFloatvEXT: int -> int -> float_array -> unit = "glstub_glGetVariantFloatvEXT" "glstub_glGetVariantFloatvEXT"
let glGetVariantFloatvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetVariantFloatvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetVariantIntegervEXT: int -> int -> word_array -> unit = "glstub_glGetVariantIntegervEXT" "glstub_glGetVariantIntegervEXT"
let glGetVariantIntegervEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetVariantIntegervEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glGetVariantPointervEXT: int -> int -> 'a -> unit = "glstub_glGetVariantPointervEXT" "glstub_glGetVariantPointervEXT"
external glGetVaryingLocationNV: int -> string -> int = "glstub_glGetVaryingLocationNV" "glstub_glGetVaryingLocationNV"

external glGetVertexAttribArrayObjectfvATI: int -> int -> float_array -> unit = "glstub_glGetVertexAttribArrayObjectfvATI" "glstub_glGetVertexAttribArrayObjectfvATI"
let glGetVertexAttribArrayObjectfvATI p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetVertexAttribArrayObjectfvATI p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetVertexAttribArrayObjectivATI: int -> int -> word_array -> unit = "glstub_glGetVertexAttribArrayObjectivATI" "glstub_glGetVertexAttribArrayObjectivATI"
let glGetVertexAttribArrayObjectivATI p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetVertexAttribArrayObjectivATI p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetVertexAttribIivEXT: int -> int -> word_array -> unit = "glstub_glGetVertexAttribIivEXT" "glstub_glGetVertexAttribIivEXT"
let glGetVertexAttribIivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetVertexAttribIivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetVertexAttribIuivEXT: int -> int -> word_array -> unit = "glstub_glGetVertexAttribIuivEXT" "glstub_glGetVertexAttribIuivEXT"
let glGetVertexAttribIuivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetVertexAttribIuivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glGetVertexAttribPointerv: int -> int -> 'a -> unit = "glstub_glGetVertexAttribPointerv" "glstub_glGetVertexAttribPointerv"
external glGetVertexAttribPointervARB: int -> int -> 'a -> unit = "glstub_glGetVertexAttribPointervARB" "glstub_glGetVertexAttribPointervARB"
external glGetVertexAttribPointervNV: int -> int -> 'a -> unit = "glstub_glGetVertexAttribPointervNV" "glstub_glGetVertexAttribPointervNV"
external glGetVertexAttribdv: int -> int -> float array -> unit = "glstub_glGetVertexAttribdv" "glstub_glGetVertexAttribdv"
external glGetVertexAttribdvARB: int -> int -> float array -> unit = "glstub_glGetVertexAttribdvARB" "glstub_glGetVertexAttribdvARB"
external glGetVertexAttribdvNV: int -> int -> float array -> unit = "glstub_glGetVertexAttribdvNV" "glstub_glGetVertexAttribdvNV"

external glGetVertexAttribfv: int -> int -> float_array -> unit = "glstub_glGetVertexAttribfv" "glstub_glGetVertexAttribfv"
let glGetVertexAttribfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetVertexAttribfv p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetVertexAttribfvARB: int -> int -> float_array -> unit = "glstub_glGetVertexAttribfvARB" "glstub_glGetVertexAttribfvARB"
let glGetVertexAttribfvARB p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetVertexAttribfvARB p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetVertexAttribfvNV: int -> int -> float_array -> unit = "glstub_glGetVertexAttribfvNV" "glstub_glGetVertexAttribfvNV"
let glGetVertexAttribfvNV p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glGetVertexAttribfvNV p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glGetVertexAttribiv: int -> int -> word_array -> unit = "glstub_glGetVertexAttribiv" "glstub_glGetVertexAttribiv"
let glGetVertexAttribiv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetVertexAttribiv p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetVertexAttribivARB: int -> int -> word_array -> unit = "glstub_glGetVertexAttribivARB" "glstub_glGetVertexAttribivARB"
let glGetVertexAttribivARB p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetVertexAttribivARB p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glGetVertexAttribivNV: int -> int -> word_array -> unit = "glstub_glGetVertexAttribivNV" "glstub_glGetVertexAttribivNV"
let glGetVertexAttribivNV p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glGetVertexAttribivNV p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glGlobalAlphaFactorbSUN: int -> unit = "glstub_glGlobalAlphaFactorbSUN" "glstub_glGlobalAlphaFactorbSUN"
external glGlobalAlphaFactordSUN: float -> unit = "glstub_glGlobalAlphaFactordSUN" "glstub_glGlobalAlphaFactordSUN"
external glGlobalAlphaFactorfSUN: float -> unit = "glstub_glGlobalAlphaFactorfSUN" "glstub_glGlobalAlphaFactorfSUN"
external glGlobalAlphaFactoriSUN: int -> unit = "glstub_glGlobalAlphaFactoriSUN" "glstub_glGlobalAlphaFactoriSUN"
external glGlobalAlphaFactorsSUN: int -> unit = "glstub_glGlobalAlphaFactorsSUN" "glstub_glGlobalAlphaFactorsSUN"
external glGlobalAlphaFactorubSUN: int -> unit = "glstub_glGlobalAlphaFactorubSUN" "glstub_glGlobalAlphaFactorubSUN"
external glGlobalAlphaFactoruiSUN: int -> unit = "glstub_glGlobalAlphaFactoruiSUN" "glstub_glGlobalAlphaFactoruiSUN"
external glGlobalAlphaFactorusSUN: int -> unit = "glstub_glGlobalAlphaFactorusSUN" "glstub_glGlobalAlphaFactorusSUN"
external glHint: int -> int -> unit = "glstub_glHint" "glstub_glHint"
external glHistogram: int -> int -> int -> bool -> unit = "glstub_glHistogram" "glstub_glHistogram"
external glHistogramEXT: int -> int -> int -> bool -> unit = "glstub_glHistogramEXT" "glstub_glHistogramEXT"
external glImageTransformParameterfHP: int -> int -> float -> unit = "glstub_glImageTransformParameterfHP" "glstub_glImageTransformParameterfHP"

external glImageTransformParameterfvHP: int -> int -> float_array -> unit = "glstub_glImageTransformParameterfvHP" "glstub_glImageTransformParameterfvHP"
let glImageTransformParameterfvHP p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glImageTransformParameterfvHP p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glImageTransformParameteriHP: int -> int -> int -> unit = "glstub_glImageTransformParameteriHP" "glstub_glImageTransformParameteriHP"

external glImageTransformParameterivHP: int -> int -> word_array -> unit = "glstub_glImageTransformParameterivHP" "glstub_glImageTransformParameterivHP"
let glImageTransformParameterivHP p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glImageTransformParameterivHP p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glIndexFuncEXT: int -> float -> unit = "glstub_glIndexFuncEXT" "glstub_glIndexFuncEXT"
external glIndexMask: int -> unit = "glstub_glIndexMask" "glstub_glIndexMask"
external glIndexMaterialEXT: int -> int -> unit = "glstub_glIndexMaterialEXT" "glstub_glIndexMaterialEXT"
external glIndexPointer: int -> int -> 'a -> unit = "glstub_glIndexPointer" "glstub_glIndexPointer"
external glIndexPointerEXT: int -> int -> int -> 'a -> unit = "glstub_glIndexPointerEXT" "glstub_glIndexPointerEXT"
external glIndexPointerListIBM: int -> int -> 'a -> int -> unit = "glstub_glIndexPointerListIBM" "glstub_glIndexPointerListIBM"
external glIndexd: float -> unit = "glstub_glIndexd" "glstub_glIndexd"
external glIndexdv: float array -> unit = "glstub_glIndexdv" "glstub_glIndexdv"
external glIndexf: float -> unit = "glstub_glIndexf" "glstub_glIndexf"

external glIndexfv: float_array -> unit = "glstub_glIndexfv" "glstub_glIndexfv"
let glIndexfv p0 =
let np0 = to_float_array p0 in
let r = glIndexfv np0 in
r

external glIndexi: int -> unit = "glstub_glIndexi" "glstub_glIndexi"

external glIndexiv: word_array -> unit = "glstub_glIndexiv" "glstub_glIndexiv"
let glIndexiv p0 =
let np0 = to_word_array p0 in
let r = glIndexiv np0 in
r

external glIndexs: int -> unit = "glstub_glIndexs" "glstub_glIndexs"

external glIndexsv: short_array -> unit = "glstub_glIndexsv" "glstub_glIndexsv"
let glIndexsv p0 =
let np0 = to_short_array p0 in
let r = glIndexsv np0 in
r

external glIndexub: int -> unit = "glstub_glIndexub" "glstub_glIndexub"

external glIndexubv: ubyte_array -> unit = "glstub_glIndexubv" "glstub_glIndexubv"
let glIndexubv p0 =
let np0 = to_ubyte_array p0 in
let r = glIndexubv np0 in
r

external glInitNames: unit -> unit = "glstub_glInitNames" "glstub_glInitNames"
external glInsertComponentEXT: int -> int -> int -> unit = "glstub_glInsertComponentEXT" "glstub_glInsertComponentEXT"
external glInterleavedArrays: int -> int -> 'a -> unit = "glstub_glInterleavedArrays" "glstub_glInterleavedArrays"
external glIsAsyncMarkerSGIX: int -> bool = "glstub_glIsAsyncMarkerSGIX" "glstub_glIsAsyncMarkerSGIX"
external glIsBuffer: int -> bool = "glstub_glIsBuffer" "glstub_glIsBuffer"
external glIsBufferARB: int -> bool = "glstub_glIsBufferARB" "glstub_glIsBufferARB"
external glIsEnabled: int -> bool = "glstub_glIsEnabled" "glstub_glIsEnabled"
external glIsEnabledIndexedEXT: int -> int -> bool = "glstub_glIsEnabledIndexedEXT" "glstub_glIsEnabledIndexedEXT"
external glIsFenceAPPLE: int -> bool = "glstub_glIsFenceAPPLE" "glstub_glIsFenceAPPLE"
external glIsFenceNV: int -> bool = "glstub_glIsFenceNV" "glstub_glIsFenceNV"
external glIsFramebufferEXT: int -> bool = "glstub_glIsFramebufferEXT" "glstub_glIsFramebufferEXT"
external glIsList: int -> bool = "glstub_glIsList" "glstub_glIsList"
external glIsObjectBufferATI: int -> bool = "glstub_glIsObjectBufferATI" "glstub_glIsObjectBufferATI"
external glIsOcclusionQueryNV: int -> bool = "glstub_glIsOcclusionQueryNV" "glstub_glIsOcclusionQueryNV"
external glIsProgram: int -> bool = "glstub_glIsProgram" "glstub_glIsProgram"
external glIsProgramARB: int -> bool = "glstub_glIsProgramARB" "glstub_glIsProgramARB"
external glIsProgramNV: int -> bool = "glstub_glIsProgramNV" "glstub_glIsProgramNV"
external glIsQuery: int -> bool = "glstub_glIsQuery" "glstub_glIsQuery"
external glIsQueryARB: int -> bool = "glstub_glIsQueryARB" "glstub_glIsQueryARB"
external glIsRenderbufferEXT: int -> bool = "glstub_glIsRenderbufferEXT" "glstub_glIsRenderbufferEXT"
external glIsShader: int -> bool = "glstub_glIsShader" "glstub_glIsShader"
external glIsTexture: int -> bool = "glstub_glIsTexture" "glstub_glIsTexture"
external glIsTextureEXT: int -> bool = "glstub_glIsTextureEXT" "glstub_glIsTextureEXT"
external glIsVariantEnabledEXT: int -> int -> bool = "glstub_glIsVariantEnabledEXT" "glstub_glIsVariantEnabledEXT"
external glIsVertexArrayAPPLE: int -> bool = "glstub_glIsVertexArrayAPPLE" "glstub_glIsVertexArrayAPPLE"
external glLightEnviEXT: int -> int -> unit = "glstub_glLightEnviEXT" "glstub_glLightEnviEXT"
external glLightModelf: int -> float -> unit = "glstub_glLightModelf" "glstub_glLightModelf"

external glLightModelfv: int -> float_array -> unit = "glstub_glLightModelfv" "glstub_glLightModelfv"
let glLightModelfv p0 p1 =
let np1 = to_float_array p1 in
let r = glLightModelfv p0 np1 in
r

external glLightModeli: int -> int -> unit = "glstub_glLightModeli" "glstub_glLightModeli"

external glLightModeliv: int -> word_array -> unit = "glstub_glLightModeliv" "glstub_glLightModeliv"
let glLightModeliv p0 p1 =
let np1 = to_word_array p1 in
let r = glLightModeliv p0 np1 in
r

external glLightf: int -> int -> float -> unit = "glstub_glLightf" "glstub_glLightf"

external glLightfv: int -> int -> float_array -> unit = "glstub_glLightfv" "glstub_glLightfv"
let glLightfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glLightfv p0 p1 np2 in
r

external glLighti: int -> int -> int -> unit = "glstub_glLighti" "glstub_glLighti"

external glLightiv: int -> int -> word_array -> unit = "glstub_glLightiv" "glstub_glLightiv"
let glLightiv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glLightiv p0 p1 np2 in
r

external glLineStipple: int -> int -> unit = "glstub_glLineStipple" "glstub_glLineStipple"
external glLineWidth: float -> unit = "glstub_glLineWidth" "glstub_glLineWidth"
external glLinkProgram: int -> unit = "glstub_glLinkProgram" "glstub_glLinkProgram"
external glLinkProgramARB: int -> unit = "glstub_glLinkProgramARB" "glstub_glLinkProgramARB"
external glListBase: int -> unit = "glstub_glListBase" "glstub_glListBase"
external glLoadIdentity: unit -> unit = "glstub_glLoadIdentity" "glstub_glLoadIdentity"
external glLoadMatrixd: float array -> unit = "glstub_glLoadMatrixd" "glstub_glLoadMatrixd"

external glLoadMatrixf: float_array -> unit = "glstub_glLoadMatrixf" "glstub_glLoadMatrixf"
let glLoadMatrixf p0 =
let np0 = to_float_array p0 in
let r = glLoadMatrixf np0 in
r

external glLoadName: int -> unit = "glstub_glLoadName" "glstub_glLoadName"

external glLoadProgramNV: int -> int -> int -> ubyte_array -> unit = "glstub_glLoadProgramNV" "glstub_glLoadProgramNV"
let glLoadProgramNV p0 p1 p2 p3 =
let np3 = to_ubyte_array p3 in
let r = glLoadProgramNV p0 p1 p2 np3 in
let _ = copy_ubyte_array np3 p3 in
r

external glLoadTransposeMatrixd: float array -> unit = "glstub_glLoadTransposeMatrixd" "glstub_glLoadTransposeMatrixd"
external glLoadTransposeMatrixdARB: float array -> unit = "glstub_glLoadTransposeMatrixdARB" "glstub_glLoadTransposeMatrixdARB"

external glLoadTransposeMatrixf: float_array -> unit = "glstub_glLoadTransposeMatrixf" "glstub_glLoadTransposeMatrixf"
let glLoadTransposeMatrixf p0 =
let np0 = to_float_array p0 in
let r = glLoadTransposeMatrixf np0 in
r


external glLoadTransposeMatrixfARB: float_array -> unit = "glstub_glLoadTransposeMatrixfARB" "glstub_glLoadTransposeMatrixfARB"
let glLoadTransposeMatrixfARB p0 =
let np0 = to_float_array p0 in
let r = glLoadTransposeMatrixfARB np0 in
let _ = copy_float_array np0 p0 in
r

external glLockArraysEXT: int -> int -> unit = "glstub_glLockArraysEXT" "glstub_glLockArraysEXT"
external glLogicOp: int -> unit = "glstub_glLogicOp" "glstub_glLogicOp"
external glMap1d: int -> float -> float -> int -> int -> float array -> unit = "glstub_glMap1d_byte" "glstub_glMap1d"

external glMap1f: int -> float -> float -> int -> int -> float_array -> unit = "glstub_glMap1f_byte" "glstub_glMap1f"
let glMap1f p0 p1 p2 p3 p4 p5 =
let np5 = to_float_array p5 in
let r = glMap1f p0 p1 p2 p3 p4 np5 in
r

external glMap2d: int -> float -> float -> int -> int -> float -> float -> int -> int -> float array -> unit = "glstub_glMap2d_byte" "glstub_glMap2d"

external glMap2f: int -> float -> float -> int -> int -> float -> float -> int -> int -> float_array -> unit = "glstub_glMap2f_byte" "glstub_glMap2f"
let glMap2f p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 =
let np9 = to_float_array p9 in
let r = glMap2f p0 p1 p2 p3 p4 p5 p6 p7 p8 np9 in
r

external glMapBuffer: int -> int -> 'a = "glstub_glMapBuffer" "glstub_glMapBuffer"
external glMapBufferARB: int -> int -> 'a = "glstub_glMapBufferARB" "glstub_glMapBufferARB"
external glMapControlPointsNV: int -> int -> int -> int -> int -> int -> int -> bool -> 'a -> unit = "glstub_glMapControlPointsNV_byte" "glstub_glMapControlPointsNV"
external glMapGrid1d: int -> float -> float -> unit = "glstub_glMapGrid1d" "glstub_glMapGrid1d"
external glMapGrid1f: int -> float -> float -> unit = "glstub_glMapGrid1f" "glstub_glMapGrid1f"
external glMapGrid2d: int -> float -> float -> int -> float -> float -> unit = "glstub_glMapGrid2d_byte" "glstub_glMapGrid2d"
external glMapGrid2f: int -> float -> float -> int -> float -> float -> unit = "glstub_glMapGrid2f_byte" "glstub_glMapGrid2f"
external glMapObjectBufferATI: int -> 'a = "glstub_glMapObjectBufferATI" "glstub_glMapObjectBufferATI"

external glMapParameterfvNV: int -> int -> float_array -> unit = "glstub_glMapParameterfvNV" "glstub_glMapParameterfvNV"
let glMapParameterfvNV p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glMapParameterfvNV p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glMapParameterivNV: int -> int -> word_array -> unit = "glstub_glMapParameterivNV" "glstub_glMapParameterivNV"
let glMapParameterivNV p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glMapParameterivNV p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glMaterialf: int -> int -> float -> unit = "glstub_glMaterialf" "glstub_glMaterialf"

external glMaterialfv: int -> int -> float_array -> unit = "glstub_glMaterialfv" "glstub_glMaterialfv"
let glMaterialfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glMaterialfv p0 p1 np2 in
r

external glMateriali: int -> int -> int -> unit = "glstub_glMateriali" "glstub_glMateriali"

external glMaterialiv: int -> int -> word_array -> unit = "glstub_glMaterialiv" "glstub_glMaterialiv"
let glMaterialiv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glMaterialiv p0 p1 np2 in
r

external glMatrixIndexPointerARB: int -> int -> int -> 'a -> unit = "glstub_glMatrixIndexPointerARB" "glstub_glMatrixIndexPointerARB"

external glMatrixIndexubvARB: int -> ubyte_array -> unit = "glstub_glMatrixIndexubvARB" "glstub_glMatrixIndexubvARB"
let glMatrixIndexubvARB p0 p1 =
let np1 = to_ubyte_array p1 in
let r = glMatrixIndexubvARB p0 np1 in
let _ = copy_ubyte_array np1 p1 in
r


external glMatrixIndexuivARB: int -> word_array -> unit = "glstub_glMatrixIndexuivARB" "glstub_glMatrixIndexuivARB"
let glMatrixIndexuivARB p0 p1 =
let np1 = to_word_array p1 in
let r = glMatrixIndexuivARB p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glMatrixIndexusvARB: int -> ushort_array -> unit = "glstub_glMatrixIndexusvARB" "glstub_glMatrixIndexusvARB"
let glMatrixIndexusvARB p0 p1 =
let np1 = to_ushort_array p1 in
let r = glMatrixIndexusvARB p0 np1 in
let _ = copy_ushort_array np1 p1 in
r

external glMatrixMode: int -> unit = "glstub_glMatrixMode" "glstub_glMatrixMode"
external glMinmax: int -> int -> bool -> unit = "glstub_glMinmax" "glstub_glMinmax"
external glMinmaxEXT: int -> int -> bool -> unit = "glstub_glMinmaxEXT" "glstub_glMinmaxEXT"
external glMultMatrixd: float array -> unit = "glstub_glMultMatrixd" "glstub_glMultMatrixd"

external glMultMatrixf: float_array -> unit = "glstub_glMultMatrixf" "glstub_glMultMatrixf"
let glMultMatrixf p0 =
let np0 = to_float_array p0 in
let r = glMultMatrixf np0 in
r

external glMultTransposeMatrixd: float array -> unit = "glstub_glMultTransposeMatrixd" "glstub_glMultTransposeMatrixd"
external glMultTransposeMatrixdARB: float array -> unit = "glstub_glMultTransposeMatrixdARB" "glstub_glMultTransposeMatrixdARB"

external glMultTransposeMatrixf: float_array -> unit = "glstub_glMultTransposeMatrixf" "glstub_glMultTransposeMatrixf"
let glMultTransposeMatrixf p0 =
let np0 = to_float_array p0 in
let r = glMultTransposeMatrixf np0 in
r


external glMultTransposeMatrixfARB: float_array -> unit = "glstub_glMultTransposeMatrixfARB" "glstub_glMultTransposeMatrixfARB"
let glMultTransposeMatrixfARB p0 =
let np0 = to_float_array p0 in
let r = glMultTransposeMatrixfARB np0 in
let _ = copy_float_array np0 p0 in
r


external glMultiDrawArrays: int -> word_array -> word_array -> int -> unit = "glstub_glMultiDrawArrays" "glstub_glMultiDrawArrays"
let glMultiDrawArrays p0 p1 p2 p3 =
let np1 = to_word_array p1 in
let np2 = to_word_array p2 in
let r = glMultiDrawArrays p0 np1 np2 p3 in
let _ = copy_word_array np1 p1 in
let _ = copy_word_array np2 p2 in
r


external glMultiDrawArraysEXT: int -> word_array -> word_array -> int -> unit = "glstub_glMultiDrawArraysEXT" "glstub_glMultiDrawArraysEXT"
let glMultiDrawArraysEXT p0 p1 p2 p3 =
let np1 = to_word_array p1 in
let np2 = to_word_array p2 in
let r = glMultiDrawArraysEXT p0 np1 np2 p3 in
let _ = copy_word_array np1 p1 in
let _ = copy_word_array np2 p2 in
r


external glMultiDrawElementArrayAPPLE: int -> word_array -> word_array -> int -> unit = "glstub_glMultiDrawElementArrayAPPLE" "glstub_glMultiDrawElementArrayAPPLE"
let glMultiDrawElementArrayAPPLE p0 p1 p2 p3 =
let np1 = to_word_array p1 in
let np2 = to_word_array p2 in
let r = glMultiDrawElementArrayAPPLE p0 np1 np2 p3 in
let _ = copy_word_array np1 p1 in
let _ = copy_word_array np2 p2 in
r


external glMultiDrawElements: int -> word_array -> int -> 'a -> int -> unit = "glstub_glMultiDrawElements" "glstub_glMultiDrawElements"
let glMultiDrawElements p0 p1 p2 p3 p4 =
let np1 = to_word_array p1 in
let r = glMultiDrawElements p0 np1 p2 p3 p4 in
let _ = copy_word_array np1 p1 in
r


external glMultiDrawElementsEXT: int -> word_array -> int -> 'a -> int -> unit = "glstub_glMultiDrawElementsEXT" "glstub_glMultiDrawElementsEXT"
let glMultiDrawElementsEXT p0 p1 p2 p3 p4 =
let np1 = to_word_array p1 in
let r = glMultiDrawElementsEXT p0 np1 p2 p3 p4 in
let _ = copy_word_array np1 p1 in
r


external glMultiDrawRangeElementArrayAPPLE: int -> int -> int -> word_array -> word_array -> int -> unit = "glstub_glMultiDrawRangeElementArrayAPPLE_byte" "glstub_glMultiDrawRangeElementArrayAPPLE"
let glMultiDrawRangeElementArrayAPPLE p0 p1 p2 p3 p4 p5 =
let np3 = to_word_array p3 in
let np4 = to_word_array p4 in
let r = glMultiDrawRangeElementArrayAPPLE p0 p1 p2 np3 np4 p5 in
let _ = copy_word_array np3 p3 in
let _ = copy_word_array np4 p4 in
r


external glMultiModeDrawArraysIBM: word_array -> word_array -> word_array -> int -> int -> unit = "glstub_glMultiModeDrawArraysIBM" "glstub_glMultiModeDrawArraysIBM"
let glMultiModeDrawArraysIBM p0 p1 p2 p3 p4 =
let np0 = to_word_array p0 in
let np1 = to_word_array p1 in
let np2 = to_word_array p2 in
let r = glMultiModeDrawArraysIBM np0 np1 np2 p3 p4 in
let _ = copy_word_array np0 p0 in
let _ = copy_word_array np1 p1 in
let _ = copy_word_array np2 p2 in
r


external glMultiModeDrawElementsIBM: word_array -> word_array -> int -> 'a -> int -> int -> unit = "glstub_glMultiModeDrawElementsIBM_byte" "glstub_glMultiModeDrawElementsIBM"
let glMultiModeDrawElementsIBM p0 p1 p2 p3 p4 p5 =
let np0 = to_word_array p0 in
let np1 = to_word_array p1 in
let r = glMultiModeDrawElementsIBM np0 np1 p2 p3 p4 p5 in
let _ = copy_word_array np0 p0 in
let _ = copy_word_array np1 p1 in
r

external glMultiTexCoord1d: int -> float -> unit = "glstub_glMultiTexCoord1d" "glstub_glMultiTexCoord1d"
external glMultiTexCoord1dARB: int -> float -> unit = "glstub_glMultiTexCoord1dARB" "glstub_glMultiTexCoord1dARB"
external glMultiTexCoord1dv: int -> float array -> unit = "glstub_glMultiTexCoord1dv" "glstub_glMultiTexCoord1dv"
external glMultiTexCoord1dvARB: int -> float array -> unit = "glstub_glMultiTexCoord1dvARB" "glstub_glMultiTexCoord1dvARB"
external glMultiTexCoord1f: int -> float -> unit = "glstub_glMultiTexCoord1f" "glstub_glMultiTexCoord1f"
external glMultiTexCoord1fARB: int -> float -> unit = "glstub_glMultiTexCoord1fARB" "glstub_glMultiTexCoord1fARB"

external glMultiTexCoord1fv: int -> float_array -> unit = "glstub_glMultiTexCoord1fv" "glstub_glMultiTexCoord1fv"
let glMultiTexCoord1fv p0 p1 =
let np1 = to_float_array p1 in
let r = glMultiTexCoord1fv p0 np1 in
r


external glMultiTexCoord1fvARB: int -> float_array -> unit = "glstub_glMultiTexCoord1fvARB" "glstub_glMultiTexCoord1fvARB"
let glMultiTexCoord1fvARB p0 p1 =
let np1 = to_float_array p1 in
let r = glMultiTexCoord1fvARB p0 np1 in
r

external glMultiTexCoord1hNV: int -> int -> unit = "glstub_glMultiTexCoord1hNV" "glstub_glMultiTexCoord1hNV"

external glMultiTexCoord1hvNV: int -> ushort_array -> unit = "glstub_glMultiTexCoord1hvNV" "glstub_glMultiTexCoord1hvNV"
let glMultiTexCoord1hvNV p0 p1 =
let np1 = to_ushort_array p1 in
let r = glMultiTexCoord1hvNV p0 np1 in
let _ = copy_ushort_array np1 p1 in
r

external glMultiTexCoord1i: int -> int -> unit = "glstub_glMultiTexCoord1i" "glstub_glMultiTexCoord1i"
external glMultiTexCoord1iARB: int -> int -> unit = "glstub_glMultiTexCoord1iARB" "glstub_glMultiTexCoord1iARB"

external glMultiTexCoord1iv: int -> word_array -> unit = "glstub_glMultiTexCoord1iv" "glstub_glMultiTexCoord1iv"
let glMultiTexCoord1iv p0 p1 =
let np1 = to_word_array p1 in
let r = glMultiTexCoord1iv p0 np1 in
r


external glMultiTexCoord1ivARB: int -> word_array -> unit = "glstub_glMultiTexCoord1ivARB" "glstub_glMultiTexCoord1ivARB"
let glMultiTexCoord1ivARB p0 p1 =
let np1 = to_word_array p1 in
let r = glMultiTexCoord1ivARB p0 np1 in
r

external glMultiTexCoord1s: int -> int -> unit = "glstub_glMultiTexCoord1s" "glstub_glMultiTexCoord1s"
external glMultiTexCoord1sARB: int -> int -> unit = "glstub_glMultiTexCoord1sARB" "glstub_glMultiTexCoord1sARB"

external glMultiTexCoord1sv: int -> short_array -> unit = "glstub_glMultiTexCoord1sv" "glstub_glMultiTexCoord1sv"
let glMultiTexCoord1sv p0 p1 =
let np1 = to_short_array p1 in
let r = glMultiTexCoord1sv p0 np1 in
r


external glMultiTexCoord1svARB: int -> short_array -> unit = "glstub_glMultiTexCoord1svARB" "glstub_glMultiTexCoord1svARB"
let glMultiTexCoord1svARB p0 p1 =
let np1 = to_short_array p1 in
let r = glMultiTexCoord1svARB p0 np1 in
r

external glMultiTexCoord2d: int -> float -> float -> unit = "glstub_glMultiTexCoord2d" "glstub_glMultiTexCoord2d"
external glMultiTexCoord2dARB: int -> float -> float -> unit = "glstub_glMultiTexCoord2dARB" "glstub_glMultiTexCoord2dARB"
external glMultiTexCoord2dv: int -> float array -> unit = "glstub_glMultiTexCoord2dv" "glstub_glMultiTexCoord2dv"
external glMultiTexCoord2dvARB: int -> float array -> unit = "glstub_glMultiTexCoord2dvARB" "glstub_glMultiTexCoord2dvARB"
external glMultiTexCoord2f: int -> float -> float -> unit = "glstub_glMultiTexCoord2f" "glstub_glMultiTexCoord2f"
external glMultiTexCoord2fARB: int -> float -> float -> unit = "glstub_glMultiTexCoord2fARB" "glstub_glMultiTexCoord2fARB"

external glMultiTexCoord2fv: int -> float_array -> unit = "glstub_glMultiTexCoord2fv" "glstub_glMultiTexCoord2fv"
let glMultiTexCoord2fv p0 p1 =
let np1 = to_float_array p1 in
let r = glMultiTexCoord2fv p0 np1 in
r


external glMultiTexCoord2fvARB: int -> float_array -> unit = "glstub_glMultiTexCoord2fvARB" "glstub_glMultiTexCoord2fvARB"
let glMultiTexCoord2fvARB p0 p1 =
let np1 = to_float_array p1 in
let r = glMultiTexCoord2fvARB p0 np1 in
r

external glMultiTexCoord2hNV: int -> int -> int -> unit = "glstub_glMultiTexCoord2hNV" "glstub_glMultiTexCoord2hNV"

external glMultiTexCoord2hvNV: int -> ushort_array -> unit = "glstub_glMultiTexCoord2hvNV" "glstub_glMultiTexCoord2hvNV"
let glMultiTexCoord2hvNV p0 p1 =
let np1 = to_ushort_array p1 in
let r = glMultiTexCoord2hvNV p0 np1 in
let _ = copy_ushort_array np1 p1 in
r

external glMultiTexCoord2i: int -> int -> int -> unit = "glstub_glMultiTexCoord2i" "glstub_glMultiTexCoord2i"
external glMultiTexCoord2iARB: int -> int -> int -> unit = "glstub_glMultiTexCoord2iARB" "glstub_glMultiTexCoord2iARB"

external glMultiTexCoord2iv: int -> word_array -> unit = "glstub_glMultiTexCoord2iv" "glstub_glMultiTexCoord2iv"
let glMultiTexCoord2iv p0 p1 =
let np1 = to_word_array p1 in
let r = glMultiTexCoord2iv p0 np1 in
r


external glMultiTexCoord2ivARB: int -> word_array -> unit = "glstub_glMultiTexCoord2ivARB" "glstub_glMultiTexCoord2ivARB"
let glMultiTexCoord2ivARB p0 p1 =
let np1 = to_word_array p1 in
let r = glMultiTexCoord2ivARB p0 np1 in
r

external glMultiTexCoord2s: int -> int -> int -> unit = "glstub_glMultiTexCoord2s" "glstub_glMultiTexCoord2s"
external glMultiTexCoord2sARB: int -> int -> int -> unit = "glstub_glMultiTexCoord2sARB" "glstub_glMultiTexCoord2sARB"

external glMultiTexCoord2sv: int -> short_array -> unit = "glstub_glMultiTexCoord2sv" "glstub_glMultiTexCoord2sv"
let glMultiTexCoord2sv p0 p1 =
let np1 = to_short_array p1 in
let r = glMultiTexCoord2sv p0 np1 in
r


external glMultiTexCoord2svARB: int -> short_array -> unit = "glstub_glMultiTexCoord2svARB" "glstub_glMultiTexCoord2svARB"
let glMultiTexCoord2svARB p0 p1 =
let np1 = to_short_array p1 in
let r = glMultiTexCoord2svARB p0 np1 in
r

external glMultiTexCoord3d: int -> float -> float -> float -> unit = "glstub_glMultiTexCoord3d" "glstub_glMultiTexCoord3d"
external glMultiTexCoord3dARB: int -> float -> float -> float -> unit = "glstub_glMultiTexCoord3dARB" "glstub_glMultiTexCoord3dARB"
external glMultiTexCoord3dv: int -> float array -> unit = "glstub_glMultiTexCoord3dv" "glstub_glMultiTexCoord3dv"
external glMultiTexCoord3dvARB: int -> float array -> unit = "glstub_glMultiTexCoord3dvARB" "glstub_glMultiTexCoord3dvARB"
external glMultiTexCoord3f: int -> float -> float -> float -> unit = "glstub_glMultiTexCoord3f" "glstub_glMultiTexCoord3f"
external glMultiTexCoord3fARB: int -> float -> float -> float -> unit = "glstub_glMultiTexCoord3fARB" "glstub_glMultiTexCoord3fARB"

external glMultiTexCoord3fv: int -> float_array -> unit = "glstub_glMultiTexCoord3fv" "glstub_glMultiTexCoord3fv"
let glMultiTexCoord3fv p0 p1 =
let np1 = to_float_array p1 in
let r = glMultiTexCoord3fv p0 np1 in
r


external glMultiTexCoord3fvARB: int -> float_array -> unit = "glstub_glMultiTexCoord3fvARB" "glstub_glMultiTexCoord3fvARB"
let glMultiTexCoord3fvARB p0 p1 =
let np1 = to_float_array p1 in
let r = glMultiTexCoord3fvARB p0 np1 in
r

external glMultiTexCoord3hNV: int -> int -> int -> int -> unit = "glstub_glMultiTexCoord3hNV" "glstub_glMultiTexCoord3hNV"

external glMultiTexCoord3hvNV: int -> ushort_array -> unit = "glstub_glMultiTexCoord3hvNV" "glstub_glMultiTexCoord3hvNV"
let glMultiTexCoord3hvNV p0 p1 =
let np1 = to_ushort_array p1 in
let r = glMultiTexCoord3hvNV p0 np1 in
let _ = copy_ushort_array np1 p1 in
r

external glMultiTexCoord3i: int -> int -> int -> int -> unit = "glstub_glMultiTexCoord3i" "glstub_glMultiTexCoord3i"
external glMultiTexCoord3iARB: int -> int -> int -> int -> unit = "glstub_glMultiTexCoord3iARB" "glstub_glMultiTexCoord3iARB"

external glMultiTexCoord3iv: int -> word_array -> unit = "glstub_glMultiTexCoord3iv" "glstub_glMultiTexCoord3iv"
let glMultiTexCoord3iv p0 p1 =
let np1 = to_word_array p1 in
let r = glMultiTexCoord3iv p0 np1 in
r


external glMultiTexCoord3ivARB: int -> word_array -> unit = "glstub_glMultiTexCoord3ivARB" "glstub_glMultiTexCoord3ivARB"
let glMultiTexCoord3ivARB p0 p1 =
let np1 = to_word_array p1 in
let r = glMultiTexCoord3ivARB p0 np1 in
r

external glMultiTexCoord3s: int -> int -> int -> int -> unit = "glstub_glMultiTexCoord3s" "glstub_glMultiTexCoord3s"
external glMultiTexCoord3sARB: int -> int -> int -> int -> unit = "glstub_glMultiTexCoord3sARB" "glstub_glMultiTexCoord3sARB"

external glMultiTexCoord3sv: int -> short_array -> unit = "glstub_glMultiTexCoord3sv" "glstub_glMultiTexCoord3sv"
let glMultiTexCoord3sv p0 p1 =
let np1 = to_short_array p1 in
let r = glMultiTexCoord3sv p0 np1 in
r


external glMultiTexCoord3svARB: int -> short_array -> unit = "glstub_glMultiTexCoord3svARB" "glstub_glMultiTexCoord3svARB"
let glMultiTexCoord3svARB p0 p1 =
let np1 = to_short_array p1 in
let r = glMultiTexCoord3svARB p0 np1 in
r

external glMultiTexCoord4d: int -> float -> float -> float -> float -> unit = "glstub_glMultiTexCoord4d" "glstub_glMultiTexCoord4d"
external glMultiTexCoord4dARB: int -> float -> float -> float -> float -> unit = "glstub_glMultiTexCoord4dARB" "glstub_glMultiTexCoord4dARB"
external glMultiTexCoord4dv: int -> float array -> unit = "glstub_glMultiTexCoord4dv" "glstub_glMultiTexCoord4dv"
external glMultiTexCoord4dvARB: int -> float array -> unit = "glstub_glMultiTexCoord4dvARB" "glstub_glMultiTexCoord4dvARB"
external glMultiTexCoord4f: int -> float -> float -> float -> float -> unit = "glstub_glMultiTexCoord4f" "glstub_glMultiTexCoord4f"
external glMultiTexCoord4fARB: int -> float -> float -> float -> float -> unit = "glstub_glMultiTexCoord4fARB" "glstub_glMultiTexCoord4fARB"

external glMultiTexCoord4fv: int -> float_array -> unit = "glstub_glMultiTexCoord4fv" "glstub_glMultiTexCoord4fv"
let glMultiTexCoord4fv p0 p1 =
let np1 = to_float_array p1 in
let r = glMultiTexCoord4fv p0 np1 in
r


external glMultiTexCoord4fvARB: int -> float_array -> unit = "glstub_glMultiTexCoord4fvARB" "glstub_glMultiTexCoord4fvARB"
let glMultiTexCoord4fvARB p0 p1 =
let np1 = to_float_array p1 in
let r = glMultiTexCoord4fvARB p0 np1 in
r

external glMultiTexCoord4hNV: int -> int -> int -> int -> int -> unit = "glstub_glMultiTexCoord4hNV" "glstub_glMultiTexCoord4hNV"

external glMultiTexCoord4hvNV: int -> ushort_array -> unit = "glstub_glMultiTexCoord4hvNV" "glstub_glMultiTexCoord4hvNV"
let glMultiTexCoord4hvNV p0 p1 =
let np1 = to_ushort_array p1 in
let r = glMultiTexCoord4hvNV p0 np1 in
let _ = copy_ushort_array np1 p1 in
r

external glMultiTexCoord4i: int -> int -> int -> int -> int -> unit = "glstub_glMultiTexCoord4i" "glstub_glMultiTexCoord4i"
external glMultiTexCoord4iARB: int -> int -> int -> int -> int -> unit = "glstub_glMultiTexCoord4iARB" "glstub_glMultiTexCoord4iARB"

external glMultiTexCoord4iv: int -> word_array -> unit = "glstub_glMultiTexCoord4iv" "glstub_glMultiTexCoord4iv"
let glMultiTexCoord4iv p0 p1 =
let np1 = to_word_array p1 in
let r = glMultiTexCoord4iv p0 np1 in
r


external glMultiTexCoord4ivARB: int -> word_array -> unit = "glstub_glMultiTexCoord4ivARB" "glstub_glMultiTexCoord4ivARB"
let glMultiTexCoord4ivARB p0 p1 =
let np1 = to_word_array p1 in
let r = glMultiTexCoord4ivARB p0 np1 in
r

external glMultiTexCoord4s: int -> int -> int -> int -> int -> unit = "glstub_glMultiTexCoord4s" "glstub_glMultiTexCoord4s"
external glMultiTexCoord4sARB: int -> int -> int -> int -> int -> unit = "glstub_glMultiTexCoord4sARB" "glstub_glMultiTexCoord4sARB"

external glMultiTexCoord4sv: int -> short_array -> unit = "glstub_glMultiTexCoord4sv" "glstub_glMultiTexCoord4sv"
let glMultiTexCoord4sv p0 p1 =
let np1 = to_short_array p1 in
let r = glMultiTexCoord4sv p0 np1 in
r


external glMultiTexCoord4svARB: int -> short_array -> unit = "glstub_glMultiTexCoord4svARB" "glstub_glMultiTexCoord4svARB"
let glMultiTexCoord4svARB p0 p1 =
let np1 = to_short_array p1 in
let r = glMultiTexCoord4svARB p0 np1 in
r

external glNewBufferRegionEXT: int -> int = "glstub_glNewBufferRegionEXT" "glstub_glNewBufferRegionEXT"
external glNewList: int -> int -> unit = "glstub_glNewList" "glstub_glNewList"
external glNewObjectBufferATI: int -> 'a -> int -> int = "glstub_glNewObjectBufferATI" "glstub_glNewObjectBufferATI"
external glNormal3b: int -> int -> int -> unit = "glstub_glNormal3b" "glstub_glNormal3b"

external glNormal3bv: byte_array -> unit = "glstub_glNormal3bv" "glstub_glNormal3bv"
let glNormal3bv p0 =
let np0 = to_byte_array p0 in
let r = glNormal3bv np0 in
r

external glNormal3d: float -> float -> float -> unit = "glstub_glNormal3d" "glstub_glNormal3d"
external glNormal3dv: float array -> unit = "glstub_glNormal3dv" "glstub_glNormal3dv"
external glNormal3f: float -> float -> float -> unit = "glstub_glNormal3f" "glstub_glNormal3f"
external glNormal3fVertex3fSUN: float -> float -> float -> float -> float -> float -> unit = "glstub_glNormal3fVertex3fSUN_byte" "glstub_glNormal3fVertex3fSUN"

external glNormal3fVertex3fvSUN: float_array -> float_array -> unit = "glstub_glNormal3fVertex3fvSUN" "glstub_glNormal3fVertex3fvSUN"
let glNormal3fVertex3fvSUN p0 p1 =
let np0 = to_float_array p0 in
let np1 = to_float_array p1 in
let r = glNormal3fVertex3fvSUN np0 np1 in
let _ = copy_float_array np0 p0 in
let _ = copy_float_array np1 p1 in
r


external glNormal3fv: float_array -> unit = "glstub_glNormal3fv" "glstub_glNormal3fv"
let glNormal3fv p0 =
let np0 = to_float_array p0 in
let r = glNormal3fv np0 in
r

external glNormal3hNV: int -> int -> int -> unit = "glstub_glNormal3hNV" "glstub_glNormal3hNV"

external glNormal3hvNV: ushort_array -> unit = "glstub_glNormal3hvNV" "glstub_glNormal3hvNV"
let glNormal3hvNV p0 =
let np0 = to_ushort_array p0 in
let r = glNormal3hvNV np0 in
let _ = copy_ushort_array np0 p0 in
r

external glNormal3i: int -> int -> int -> unit = "glstub_glNormal3i" "glstub_glNormal3i"

external glNormal3iv: word_array -> unit = "glstub_glNormal3iv" "glstub_glNormal3iv"
let glNormal3iv p0 =
let np0 = to_word_array p0 in
let r = glNormal3iv np0 in
r

external glNormal3s: int -> int -> int -> unit = "glstub_glNormal3s" "glstub_glNormal3s"

external glNormal3sv: short_array -> unit = "glstub_glNormal3sv" "glstub_glNormal3sv"
let glNormal3sv p0 =
let np0 = to_short_array p0 in
let r = glNormal3sv np0 in
r

external glNormalPointer: int -> int -> 'a -> unit = "glstub_glNormalPointer" "glstub_glNormalPointer"
external glNormalPointerEXT: int -> int -> int -> 'a -> unit = "glstub_glNormalPointerEXT" "glstub_glNormalPointerEXT"
external glNormalPointerListIBM: int -> int -> 'a -> int -> unit = "glstub_glNormalPointerListIBM" "glstub_glNormalPointerListIBM"
external glNormalPointervINTEL: int -> 'a -> unit = "glstub_glNormalPointervINTEL" "glstub_glNormalPointervINTEL"
external glNormalStream3bATI: int -> int -> int -> int -> unit = "glstub_glNormalStream3bATI" "glstub_glNormalStream3bATI"

external glNormalStream3bvATI: int -> byte_array -> unit = "glstub_glNormalStream3bvATI" "glstub_glNormalStream3bvATI"
let glNormalStream3bvATI p0 p1 =
let np1 = to_byte_array p1 in
let r = glNormalStream3bvATI p0 np1 in
r

external glNormalStream3dATI: int -> float -> float -> float -> unit = "glstub_glNormalStream3dATI" "glstub_glNormalStream3dATI"
external glNormalStream3dvATI: int -> float array -> unit = "glstub_glNormalStream3dvATI" "glstub_glNormalStream3dvATI"
external glNormalStream3fATI: int -> float -> float -> float -> unit = "glstub_glNormalStream3fATI" "glstub_glNormalStream3fATI"

external glNormalStream3fvATI: int -> float_array -> unit = "glstub_glNormalStream3fvATI" "glstub_glNormalStream3fvATI"
let glNormalStream3fvATI p0 p1 =
let np1 = to_float_array p1 in
let r = glNormalStream3fvATI p0 np1 in
r

external glNormalStream3iATI: int -> int -> int -> int -> unit = "glstub_glNormalStream3iATI" "glstub_glNormalStream3iATI"

external glNormalStream3ivATI: int -> word_array -> unit = "glstub_glNormalStream3ivATI" "glstub_glNormalStream3ivATI"
let glNormalStream3ivATI p0 p1 =
let np1 = to_word_array p1 in
let r = glNormalStream3ivATI p0 np1 in
r

external glNormalStream3sATI: int -> int -> int -> int -> unit = "glstub_glNormalStream3sATI" "glstub_glNormalStream3sATI"

external glNormalStream3svATI: int -> short_array -> unit = "glstub_glNormalStream3svATI" "glstub_glNormalStream3svATI"
let glNormalStream3svATI p0 p1 =
let np1 = to_short_array p1 in
let r = glNormalStream3svATI p0 np1 in
r

external glOrtho: float -> float -> float -> float -> float -> float -> unit = "glstub_glOrtho_byte" "glstub_glOrtho"
external glOrthofOES: float -> float -> float -> float -> float -> float -> unit = "glstub_glOrthofOES_byte" "glstub_glOrthofOES"
external glPNTrianglesfATI: int -> float -> unit = "glstub_glPNTrianglesfATI" "glstub_glPNTrianglesfATI"
external glPNTrianglesiATI: int -> int -> unit = "glstub_glPNTrianglesiATI" "glstub_glPNTrianglesiATI"
external glPassTexCoordATI: int -> int -> int -> unit = "glstub_glPassTexCoordATI" "glstub_glPassTexCoordATI"
external glPassThrough: float -> unit = "glstub_glPassThrough" "glstub_glPassThrough"
external glPixelDataRangeNV: int -> int -> 'a -> unit = "glstub_glPixelDataRangeNV" "glstub_glPixelDataRangeNV"

external glPixelMapfv: int -> int -> float_array -> unit = "glstub_glPixelMapfv" "glstub_glPixelMapfv"
let glPixelMapfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glPixelMapfv p0 p1 np2 in
r


external glPixelMapuiv: int -> int -> word_array -> unit = "glstub_glPixelMapuiv" "glstub_glPixelMapuiv"
let glPixelMapuiv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glPixelMapuiv p0 p1 np2 in
r


external glPixelMapusv: int -> int -> ushort_array -> unit = "glstub_glPixelMapusv" "glstub_glPixelMapusv"
let glPixelMapusv p0 p1 p2 =
let np2 = to_ushort_array p2 in
let r = glPixelMapusv p0 p1 np2 in
r

external glPixelStoref: int -> float -> unit = "glstub_glPixelStoref" "glstub_glPixelStoref"
external glPixelStorei: int -> int -> unit = "glstub_glPixelStorei" "glstub_glPixelStorei"
external glPixelTexGenSGIX: int -> unit = "glstub_glPixelTexGenSGIX" "glstub_glPixelTexGenSGIX"
external glPixelTransferf: int -> float -> unit = "glstub_glPixelTransferf" "glstub_glPixelTransferf"
external glPixelTransferi: int -> int -> unit = "glstub_glPixelTransferi" "glstub_glPixelTransferi"
external glPixelTransformParameterfEXT: int -> int -> float -> unit = "glstub_glPixelTransformParameterfEXT" "glstub_glPixelTransformParameterfEXT"

external glPixelTransformParameterfvEXT: int -> int -> float_array -> unit = "glstub_glPixelTransformParameterfvEXT" "glstub_glPixelTransformParameterfvEXT"
let glPixelTransformParameterfvEXT p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glPixelTransformParameterfvEXT p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glPixelTransformParameteriEXT: int -> int -> int -> unit = "glstub_glPixelTransformParameteriEXT" "glstub_glPixelTransformParameteriEXT"

external glPixelTransformParameterivEXT: int -> int -> word_array -> unit = "glstub_glPixelTransformParameterivEXT" "glstub_glPixelTransformParameterivEXT"
let glPixelTransformParameterivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glPixelTransformParameterivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glPixelZoom: float -> float -> unit = "glstub_glPixelZoom" "glstub_glPixelZoom"
external glPointParameterf: int -> float -> unit = "glstub_glPointParameterf" "glstub_glPointParameterf"
external glPointParameterfARB: int -> float -> unit = "glstub_glPointParameterfARB" "glstub_glPointParameterfARB"
external glPointParameterfEXT: int -> float -> unit = "glstub_glPointParameterfEXT" "glstub_glPointParameterfEXT"

external glPointParameterfv: int -> float_array -> unit = "glstub_glPointParameterfv" "glstub_glPointParameterfv"
let glPointParameterfv p0 p1 =
let np1 = to_float_array p1 in
let r = glPointParameterfv p0 np1 in
let _ = copy_float_array np1 p1 in
r


external glPointParameterfvARB: int -> float_array -> unit = "glstub_glPointParameterfvARB" "glstub_glPointParameterfvARB"
let glPointParameterfvARB p0 p1 =
let np1 = to_float_array p1 in
let r = glPointParameterfvARB p0 np1 in
let _ = copy_float_array np1 p1 in
r


external glPointParameterfvEXT: int -> float_array -> unit = "glstub_glPointParameterfvEXT" "glstub_glPointParameterfvEXT"
let glPointParameterfvEXT p0 p1 =
let np1 = to_float_array p1 in
let r = glPointParameterfvEXT p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glPointParameteriNV: int -> int -> unit = "glstub_glPointParameteriNV" "glstub_glPointParameteriNV"

external glPointParameterivNV: int -> word_array -> unit = "glstub_glPointParameterivNV" "glstub_glPointParameterivNV"
let glPointParameterivNV p0 p1 =
let np1 = to_word_array p1 in
let r = glPointParameterivNV p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glPointSize: float -> unit = "glstub_glPointSize" "glstub_glPointSize"

external glPollAsyncSGIX: word_array -> int = "glstub_glPollAsyncSGIX" "glstub_glPollAsyncSGIX"
let glPollAsyncSGIX p0 =
let np0 = to_word_array p0 in
let r = glPollAsyncSGIX np0 in
let _ = copy_word_array np0 p0 in
r

external glPolygonMode: int -> int -> unit = "glstub_glPolygonMode" "glstub_glPolygonMode"
external glPolygonOffset: float -> float -> unit = "glstub_glPolygonOffset" "glstub_glPolygonOffset"
external glPolygonOffsetEXT: float -> float -> unit = "glstub_glPolygonOffsetEXT" "glstub_glPolygonOffsetEXT"

external glPolygonStipple: ubyte_array -> unit = "glstub_glPolygonStipple" "glstub_glPolygonStipple"
let glPolygonStipple p0 =
let np0 = to_ubyte_array p0 in
let r = glPolygonStipple np0 in
r

external glPopAttrib: unit -> unit = "glstub_glPopAttrib" "glstub_glPopAttrib"
external glPopClientAttrib: unit -> unit = "glstub_glPopClientAttrib" "glstub_glPopClientAttrib"
external glPopMatrix: unit -> unit = "glstub_glPopMatrix" "glstub_glPopMatrix"
external glPopName: unit -> unit = "glstub_glPopName" "glstub_glPopName"
external glPrimitiveRestartIndexNV: int -> unit = "glstub_glPrimitiveRestartIndexNV" "glstub_glPrimitiveRestartIndexNV"
external glPrimitiveRestartNV: unit -> unit = "glstub_glPrimitiveRestartNV" "glstub_glPrimitiveRestartNV"

external glPrioritizeTextures: int -> word_array -> float_array -> unit = "glstub_glPrioritizeTextures" "glstub_glPrioritizeTextures"
let glPrioritizeTextures p0 p1 p2 =
let np1 = to_word_array p1 in
let np2 = to_float_array p2 in
let r = glPrioritizeTextures p0 np1 np2 in
r


external glPrioritizeTexturesEXT: int -> word_array -> float_array -> unit = "glstub_glPrioritizeTexturesEXT" "glstub_glPrioritizeTexturesEXT"
let glPrioritizeTexturesEXT p0 p1 p2 =
let np1 = to_word_array p1 in
let np2 = to_float_array p2 in
let r = glPrioritizeTexturesEXT p0 np1 np2 in
let _ = copy_word_array np1 p1 in
let _ = copy_float_array np2 p2 in
r


external glProgramBufferParametersIivNV: int -> int -> int -> int -> word_array -> unit = "glstub_glProgramBufferParametersIivNV" "glstub_glProgramBufferParametersIivNV"
let glProgramBufferParametersIivNV p0 p1 p2 p3 p4 =
let np4 = to_word_array p4 in
let r = glProgramBufferParametersIivNV p0 p1 p2 p3 np4 in
let _ = copy_word_array np4 p4 in
r


external glProgramBufferParametersIuivNV: int -> int -> int -> int -> word_array -> unit = "glstub_glProgramBufferParametersIuivNV" "glstub_glProgramBufferParametersIuivNV"
let glProgramBufferParametersIuivNV p0 p1 p2 p3 p4 =
let np4 = to_word_array p4 in
let r = glProgramBufferParametersIuivNV p0 p1 p2 p3 np4 in
let _ = copy_word_array np4 p4 in
r


external glProgramBufferParametersfvNV: int -> int -> int -> int -> float_array -> unit = "glstub_glProgramBufferParametersfvNV" "glstub_glProgramBufferParametersfvNV"
let glProgramBufferParametersfvNV p0 p1 p2 p3 p4 =
let np4 = to_float_array p4 in
let r = glProgramBufferParametersfvNV p0 p1 p2 p3 np4 in
let _ = copy_float_array np4 p4 in
r

external glProgramEnvParameter4dARB: int -> int -> float -> float -> float -> float -> unit = "glstub_glProgramEnvParameter4dARB_byte" "glstub_glProgramEnvParameter4dARB"
external glProgramEnvParameter4dvARB: int -> int -> float array -> unit = "glstub_glProgramEnvParameter4dvARB" "glstub_glProgramEnvParameter4dvARB"
external glProgramEnvParameter4fARB: int -> int -> float -> float -> float -> float -> unit = "glstub_glProgramEnvParameter4fARB_byte" "glstub_glProgramEnvParameter4fARB"

external glProgramEnvParameter4fvARB: int -> int -> float_array -> unit = "glstub_glProgramEnvParameter4fvARB" "glstub_glProgramEnvParameter4fvARB"
let glProgramEnvParameter4fvARB p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glProgramEnvParameter4fvARB p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glProgramEnvParameterI4iNV: int -> int -> int -> int -> int -> int -> unit = "glstub_glProgramEnvParameterI4iNV_byte" "glstub_glProgramEnvParameterI4iNV"

external glProgramEnvParameterI4ivNV: int -> int -> word_array -> unit = "glstub_glProgramEnvParameterI4ivNV" "glstub_glProgramEnvParameterI4ivNV"
let glProgramEnvParameterI4ivNV p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glProgramEnvParameterI4ivNV p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glProgramEnvParameterI4uiNV: int -> int -> int -> int -> int -> int -> unit = "glstub_glProgramEnvParameterI4uiNV_byte" "glstub_glProgramEnvParameterI4uiNV"

external glProgramEnvParameterI4uivNV: int -> int -> word_array -> unit = "glstub_glProgramEnvParameterI4uivNV" "glstub_glProgramEnvParameterI4uivNV"
let glProgramEnvParameterI4uivNV p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glProgramEnvParameterI4uivNV p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glProgramEnvParameters4fvEXT: int -> int -> int -> float_array -> unit = "glstub_glProgramEnvParameters4fvEXT" "glstub_glProgramEnvParameters4fvEXT"
let glProgramEnvParameters4fvEXT p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glProgramEnvParameters4fvEXT p0 p1 p2 np3 in
let _ = copy_float_array np3 p3 in
r


external glProgramEnvParametersI4ivNV: int -> int -> int -> word_array -> unit = "glstub_glProgramEnvParametersI4ivNV" "glstub_glProgramEnvParametersI4ivNV"
let glProgramEnvParametersI4ivNV p0 p1 p2 p3 =
let np3 = to_word_array p3 in
let r = glProgramEnvParametersI4ivNV p0 p1 p2 np3 in
let _ = copy_word_array np3 p3 in
r


external glProgramEnvParametersI4uivNV: int -> int -> int -> word_array -> unit = "glstub_glProgramEnvParametersI4uivNV" "glstub_glProgramEnvParametersI4uivNV"
let glProgramEnvParametersI4uivNV p0 p1 p2 p3 =
let np3 = to_word_array p3 in
let r = glProgramEnvParametersI4uivNV p0 p1 p2 np3 in
let _ = copy_word_array np3 p3 in
r

external glProgramLocalParameter4dARB: int -> int -> float -> float -> float -> float -> unit = "glstub_glProgramLocalParameter4dARB_byte" "glstub_glProgramLocalParameter4dARB"
external glProgramLocalParameter4dvARB: int -> int -> float array -> unit = "glstub_glProgramLocalParameter4dvARB" "glstub_glProgramLocalParameter4dvARB"
external glProgramLocalParameter4fARB: int -> int -> float -> float -> float -> float -> unit = "glstub_glProgramLocalParameter4fARB_byte" "glstub_glProgramLocalParameter4fARB"

external glProgramLocalParameter4fvARB: int -> int -> float_array -> unit = "glstub_glProgramLocalParameter4fvARB" "glstub_glProgramLocalParameter4fvARB"
let glProgramLocalParameter4fvARB p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glProgramLocalParameter4fvARB p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glProgramLocalParameterI4iNV: int -> int -> int -> int -> int -> int -> unit = "glstub_glProgramLocalParameterI4iNV_byte" "glstub_glProgramLocalParameterI4iNV"

external glProgramLocalParameterI4ivNV: int -> int -> word_array -> unit = "glstub_glProgramLocalParameterI4ivNV" "glstub_glProgramLocalParameterI4ivNV"
let glProgramLocalParameterI4ivNV p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glProgramLocalParameterI4ivNV p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glProgramLocalParameterI4uiNV: int -> int -> int -> int -> int -> int -> unit = "glstub_glProgramLocalParameterI4uiNV_byte" "glstub_glProgramLocalParameterI4uiNV"

external glProgramLocalParameterI4uivNV: int -> int -> word_array -> unit = "glstub_glProgramLocalParameterI4uivNV" "glstub_glProgramLocalParameterI4uivNV"
let glProgramLocalParameterI4uivNV p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glProgramLocalParameterI4uivNV p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glProgramLocalParameters4fvEXT: int -> int -> int -> float_array -> unit = "glstub_glProgramLocalParameters4fvEXT" "glstub_glProgramLocalParameters4fvEXT"
let glProgramLocalParameters4fvEXT p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glProgramLocalParameters4fvEXT p0 p1 p2 np3 in
let _ = copy_float_array np3 p3 in
r


external glProgramLocalParametersI4ivNV: int -> int -> int -> word_array -> unit = "glstub_glProgramLocalParametersI4ivNV" "glstub_glProgramLocalParametersI4ivNV"
let glProgramLocalParametersI4ivNV p0 p1 p2 p3 =
let np3 = to_word_array p3 in
let r = glProgramLocalParametersI4ivNV p0 p1 p2 np3 in
let _ = copy_word_array np3 p3 in
r


external glProgramLocalParametersI4uivNV: int -> int -> int -> word_array -> unit = "glstub_glProgramLocalParametersI4uivNV" "glstub_glProgramLocalParametersI4uivNV"
let glProgramLocalParametersI4uivNV p0 p1 p2 p3 =
let np3 = to_word_array p3 in
let r = glProgramLocalParametersI4uivNV p0 p1 p2 np3 in
let _ = copy_word_array np3 p3 in
r


external glProgramNamedParameter4dNV: int -> int -> ubyte_array -> float -> float -> float -> float -> unit = "glstub_glProgramNamedParameter4dNV_byte" "glstub_glProgramNamedParameter4dNV"
let glProgramNamedParameter4dNV p0 p1 p2 p3 p4 p5 p6 =
let np2 = to_ubyte_array p2 in
let r = glProgramNamedParameter4dNV p0 p1 np2 p3 p4 p5 p6 in
let _ = copy_ubyte_array np2 p2 in
r


external glProgramNamedParameter4dvNV: int -> int -> ubyte_array -> float array -> unit = "glstub_glProgramNamedParameter4dvNV" "glstub_glProgramNamedParameter4dvNV"
let glProgramNamedParameter4dvNV p0 p1 p2 p3 =
let np2 = to_ubyte_array p2 in
let r = glProgramNamedParameter4dvNV p0 p1 np2 p3 in
let _ = copy_ubyte_array np2 p2 in
r


external glProgramNamedParameter4fNV: int -> int -> ubyte_array -> float -> float -> float -> float -> unit = "glstub_glProgramNamedParameter4fNV_byte" "glstub_glProgramNamedParameter4fNV"
let glProgramNamedParameter4fNV p0 p1 p2 p3 p4 p5 p6 =
let np2 = to_ubyte_array p2 in
let r = glProgramNamedParameter4fNV p0 p1 np2 p3 p4 p5 p6 in
let _ = copy_ubyte_array np2 p2 in
r


external glProgramNamedParameter4fvNV: int -> int -> ubyte_array -> float_array -> unit = "glstub_glProgramNamedParameter4fvNV" "glstub_glProgramNamedParameter4fvNV"
let glProgramNamedParameter4fvNV p0 p1 p2 p3 =
let np2 = to_ubyte_array p2 in
let np3 = to_float_array p3 in
let r = glProgramNamedParameter4fvNV p0 p1 np2 np3 in
let _ = copy_ubyte_array np2 p2 in
let _ = copy_float_array np3 p3 in
r

external glProgramParameter4dNV: int -> int -> float -> float -> float -> float -> unit = "glstub_glProgramParameter4dNV_byte" "glstub_glProgramParameter4dNV"
external glProgramParameter4dvNV: int -> int -> float array -> unit = "glstub_glProgramParameter4dvNV" "glstub_glProgramParameter4dvNV"
external glProgramParameter4fNV: int -> int -> float -> float -> float -> float -> unit = "glstub_glProgramParameter4fNV_byte" "glstub_glProgramParameter4fNV"

external glProgramParameter4fvNV: int -> int -> float_array -> unit = "glstub_glProgramParameter4fvNV" "glstub_glProgramParameter4fvNV"
let glProgramParameter4fvNV p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glProgramParameter4fvNV p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glProgramParameteriEXT: int -> int -> int -> unit = "glstub_glProgramParameteriEXT" "glstub_glProgramParameteriEXT"
external glProgramParameters4dvNV: int -> int -> int -> float array -> unit = "glstub_glProgramParameters4dvNV" "glstub_glProgramParameters4dvNV"

external glProgramParameters4fvNV: int -> int -> int -> float_array -> unit = "glstub_glProgramParameters4fvNV" "glstub_glProgramParameters4fvNV"
let glProgramParameters4fvNV p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glProgramParameters4fvNV p0 p1 p2 np3 in
let _ = copy_float_array np3 p3 in
r

external glProgramStringARB: int -> int -> int -> 'a -> unit = "glstub_glProgramStringARB" "glstub_glProgramStringARB"
external glProgramVertexLimitNV: int -> int -> unit = "glstub_glProgramVertexLimitNV" "glstub_glProgramVertexLimitNV"
external glPushAttrib: int -> unit = "glstub_glPushAttrib" "glstub_glPushAttrib"
external glPushClientAttrib: int -> unit = "glstub_glPushClientAttrib" "glstub_glPushClientAttrib"
external glPushMatrix: unit -> unit = "glstub_glPushMatrix" "glstub_glPushMatrix"
external glPushName: int -> unit = "glstub_glPushName" "glstub_glPushName"
external glRasterPos2d: float -> float -> unit = "glstub_glRasterPos2d" "glstub_glRasterPos2d"
external glRasterPos2dv: float array -> unit = "glstub_glRasterPos2dv" "glstub_glRasterPos2dv"
external glRasterPos2f: float -> float -> unit = "glstub_glRasterPos2f" "glstub_glRasterPos2f"

external glRasterPos2fv: float_array -> unit = "glstub_glRasterPos2fv" "glstub_glRasterPos2fv"
let glRasterPos2fv p0 =
let np0 = to_float_array p0 in
let r = glRasterPos2fv np0 in
r

external glRasterPos2i: int -> int -> unit = "glstub_glRasterPos2i" "glstub_glRasterPos2i"

external glRasterPos2iv: word_array -> unit = "glstub_glRasterPos2iv" "glstub_glRasterPos2iv"
let glRasterPos2iv p0 =
let np0 = to_word_array p0 in
let r = glRasterPos2iv np0 in
r

external glRasterPos2s: int -> int -> unit = "glstub_glRasterPos2s" "glstub_glRasterPos2s"

external glRasterPos2sv: short_array -> unit = "glstub_glRasterPos2sv" "glstub_glRasterPos2sv"
let glRasterPos2sv p0 =
let np0 = to_short_array p0 in
let r = glRasterPos2sv np0 in
r

external glRasterPos3d: float -> float -> float -> unit = "glstub_glRasterPos3d" "glstub_glRasterPos3d"
external glRasterPos3dv: float array -> unit = "glstub_glRasterPos3dv" "glstub_glRasterPos3dv"
external glRasterPos3f: float -> float -> float -> unit = "glstub_glRasterPos3f" "glstub_glRasterPos3f"

external glRasterPos3fv: float_array -> unit = "glstub_glRasterPos3fv" "glstub_glRasterPos3fv"
let glRasterPos3fv p0 =
let np0 = to_float_array p0 in
let r = glRasterPos3fv np0 in
r

external glRasterPos3i: int -> int -> int -> unit = "glstub_glRasterPos3i" "glstub_glRasterPos3i"

external glRasterPos3iv: word_array -> unit = "glstub_glRasterPos3iv" "glstub_glRasterPos3iv"
let glRasterPos3iv p0 =
let np0 = to_word_array p0 in
let r = glRasterPos3iv np0 in
r

external glRasterPos3s: int -> int -> int -> unit = "glstub_glRasterPos3s" "glstub_glRasterPos3s"

external glRasterPos3sv: short_array -> unit = "glstub_glRasterPos3sv" "glstub_glRasterPos3sv"
let glRasterPos3sv p0 =
let np0 = to_short_array p0 in
let r = glRasterPos3sv np0 in
r

external glRasterPos4d: float -> float -> float -> float -> unit = "glstub_glRasterPos4d" "glstub_glRasterPos4d"
external glRasterPos4dv: float array -> unit = "glstub_glRasterPos4dv" "glstub_glRasterPos4dv"
external glRasterPos4f: float -> float -> float -> float -> unit = "glstub_glRasterPos4f" "glstub_glRasterPos4f"

external glRasterPos4fv: float_array -> unit = "glstub_glRasterPos4fv" "glstub_glRasterPos4fv"
let glRasterPos4fv p0 =
let np0 = to_float_array p0 in
let r = glRasterPos4fv np0 in
r

external glRasterPos4i: int -> int -> int -> int -> unit = "glstub_glRasterPos4i" "glstub_glRasterPos4i"

external glRasterPos4iv: word_array -> unit = "glstub_glRasterPos4iv" "glstub_glRasterPos4iv"
let glRasterPos4iv p0 =
let np0 = to_word_array p0 in
let r = glRasterPos4iv np0 in
r

external glRasterPos4s: int -> int -> int -> int -> unit = "glstub_glRasterPos4s" "glstub_glRasterPos4s"

external glRasterPos4sv: short_array -> unit = "glstub_glRasterPos4sv" "glstub_glRasterPos4sv"
let glRasterPos4sv p0 =
let np0 = to_short_array p0 in
let r = glRasterPos4sv np0 in
r

external glReadBuffer: int -> unit = "glstub_glReadBuffer" "glstub_glReadBuffer"
external glReadBufferRegionEXT: int -> int -> int -> int -> int -> unit = "glstub_glReadBufferRegionEXT" "glstub_glReadBufferRegionEXT"
external glReadPixels: int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glReadPixels_byte" "glstub_glReadPixels"
external glReadVideoPixelsSUN: int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glReadVideoPixelsSUN_byte" "glstub_glReadVideoPixelsSUN"
external glRectd: float -> float -> float -> float -> unit = "glstub_glRectd" "glstub_glRectd"
external glRectdv: float array -> float array -> unit = "glstub_glRectdv" "glstub_glRectdv"
external glRectf: float -> float -> float -> float -> unit = "glstub_glRectf" "glstub_glRectf"

external glRectfv: float_array -> float_array -> unit = "glstub_glRectfv" "glstub_glRectfv"
let glRectfv p0 p1 =
let np0 = to_float_array p0 in
let np1 = to_float_array p1 in
let r = glRectfv np0 np1 in
r

external glRecti: int -> int -> int -> int -> unit = "glstub_glRecti" "glstub_glRecti"

external glRectiv: word_array -> word_array -> unit = "glstub_glRectiv" "glstub_glRectiv"
let glRectiv p0 p1 =
let np0 = to_word_array p0 in
let np1 = to_word_array p1 in
let r = glRectiv np0 np1 in
r

external glRects: int -> int -> int -> int -> unit = "glstub_glRects" "glstub_glRects"

external glRectsv: short_array -> short_array -> unit = "glstub_glRectsv" "glstub_glRectsv"
let glRectsv p0 p1 =
let np0 = to_short_array p0 in
let np1 = to_short_array p1 in
let r = glRectsv np0 np1 in
r

external glReferencePlaneSGIX: float array -> unit = "glstub_glReferencePlaneSGIX" "glstub_glReferencePlaneSGIX"
external glRenderMode: int -> int = "glstub_glRenderMode" "glstub_glRenderMode"
external glRenderbufferStorageEXT: int -> int -> int -> int -> unit = "glstub_glRenderbufferStorageEXT" "glstub_glRenderbufferStorageEXT"
external glRenderbufferStorageMultisampleCoverageNV: int -> int -> int -> int -> int -> int -> unit = "glstub_glRenderbufferStorageMultisampleCoverageNV_byte" "glstub_glRenderbufferStorageMultisampleCoverageNV"
external glRenderbufferStorageMultisampleEXT: int -> int -> int -> int -> int -> unit = "glstub_glRenderbufferStorageMultisampleEXT" "glstub_glRenderbufferStorageMultisampleEXT"
external glReplacementCodePointerSUN: int -> int -> 'a -> unit = "glstub_glReplacementCodePointerSUN" "glstub_glReplacementCodePointerSUN"
external glReplacementCodeubSUN: int -> unit = "glstub_glReplacementCodeubSUN" "glstub_glReplacementCodeubSUN"

external glReplacementCodeubvSUN: ubyte_array -> unit = "glstub_glReplacementCodeubvSUN" "glstub_glReplacementCodeubvSUN"
let glReplacementCodeubvSUN p0 =
let np0 = to_ubyte_array p0 in
let r = glReplacementCodeubvSUN np0 in
let _ = copy_ubyte_array np0 p0 in
r

external glReplacementCodeuiColor3fVertex3fSUN: int -> float -> float -> float -> float -> float -> float -> unit = "glstub_glReplacementCodeuiColor3fVertex3fSUN_byte" "glstub_glReplacementCodeuiColor3fVertex3fSUN"

external glReplacementCodeuiColor3fVertex3fvSUN: word_array -> float_array -> float_array -> unit = "glstub_glReplacementCodeuiColor3fVertex3fvSUN" "glstub_glReplacementCodeuiColor3fVertex3fvSUN"
let glReplacementCodeuiColor3fVertex3fvSUN p0 p1 p2 =
let np0 = to_word_array p0 in
let np1 = to_float_array p1 in
let np2 = to_float_array p2 in
let r = glReplacementCodeuiColor3fVertex3fvSUN np0 np1 np2 in
let _ = copy_word_array np0 p0 in
let _ = copy_float_array np1 p1 in
let _ = copy_float_array np2 p2 in
r

external glReplacementCodeuiColor4fNormal3fVertex3fSUN: int -> float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> unit = "glstub_glReplacementCodeuiColor4fNormal3fVertex3fSUN_byte" "glstub_glReplacementCodeuiColor4fNormal3fVertex3fSUN"

external glReplacementCodeuiColor4fNormal3fVertex3fvSUN: word_array -> float_array -> float_array -> float_array -> unit = "glstub_glReplacementCodeuiColor4fNormal3fVertex3fvSUN" "glstub_glReplacementCodeuiColor4fNormal3fVertex3fvSUN"
let glReplacementCodeuiColor4fNormal3fVertex3fvSUN p0 p1 p2 p3 =
let np0 = to_word_array p0 in
let np1 = to_float_array p1 in
let np2 = to_float_array p2 in
let np3 = to_float_array p3 in
let r = glReplacementCodeuiColor4fNormal3fVertex3fvSUN np0 np1 np2 np3 in
let _ = copy_word_array np0 p0 in
let _ = copy_float_array np1 p1 in
let _ = copy_float_array np2 p2 in
let _ = copy_float_array np3 p3 in
r

external glReplacementCodeuiColor4ubVertex3fSUN: int -> int -> int -> int -> int -> float -> float -> float -> unit = "glstub_glReplacementCodeuiColor4ubVertex3fSUN_byte" "glstub_glReplacementCodeuiColor4ubVertex3fSUN"

external glReplacementCodeuiColor4ubVertex3fvSUN: word_array -> ubyte_array -> float_array -> unit = "glstub_glReplacementCodeuiColor4ubVertex3fvSUN" "glstub_glReplacementCodeuiColor4ubVertex3fvSUN"
let glReplacementCodeuiColor4ubVertex3fvSUN p0 p1 p2 =
let np0 = to_word_array p0 in
let np1 = to_ubyte_array p1 in
let np2 = to_float_array p2 in
let r = glReplacementCodeuiColor4ubVertex3fvSUN np0 np1 np2 in
let _ = copy_word_array np0 p0 in
let _ = copy_ubyte_array np1 p1 in
let _ = copy_float_array np2 p2 in
r

external glReplacementCodeuiNormal3fVertex3fSUN: int -> float -> float -> float -> float -> float -> float -> unit = "glstub_glReplacementCodeuiNormal3fVertex3fSUN_byte" "glstub_glReplacementCodeuiNormal3fVertex3fSUN"

external glReplacementCodeuiNormal3fVertex3fvSUN: word_array -> float_array -> float_array -> unit = "glstub_glReplacementCodeuiNormal3fVertex3fvSUN" "glstub_glReplacementCodeuiNormal3fVertex3fvSUN"
let glReplacementCodeuiNormal3fVertex3fvSUN p0 p1 p2 =
let np0 = to_word_array p0 in
let np1 = to_float_array p1 in
let np2 = to_float_array p2 in
let r = glReplacementCodeuiNormal3fVertex3fvSUN np0 np1 np2 in
let _ = copy_word_array np0 p0 in
let _ = copy_float_array np1 p1 in
let _ = copy_float_array np2 p2 in
r

external glReplacementCodeuiSUN: int -> unit = "glstub_glReplacementCodeuiSUN" "glstub_glReplacementCodeuiSUN"
external glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN: int -> float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> unit = "glstub_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN_byte" "glstub_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN"

external glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN: word_array -> float_array -> float_array -> float_array -> float_array -> unit = "glstub_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN" "glstub_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN"
let glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN p0 p1 p2 p3 p4 =
let np0 = to_word_array p0 in
let np1 = to_float_array p1 in
let np2 = to_float_array p2 in
let np3 = to_float_array p3 in
let np4 = to_float_array p4 in
let r = glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN np0 np1 np2 np3 np4 in
let _ = copy_word_array np0 p0 in
let _ = copy_float_array np1 p1 in
let _ = copy_float_array np2 p2 in
let _ = copy_float_array np3 p3 in
let _ = copy_float_array np4 p4 in
r

external glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN: int -> float -> float -> float -> float -> float -> float -> float -> float -> unit = "glstub_glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN_byte" "glstub_glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN"

external glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN: word_array -> float_array -> float_array -> float_array -> unit = "glstub_glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN" "glstub_glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN"
let glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN p0 p1 p2 p3 =
let np0 = to_word_array p0 in
let np1 = to_float_array p1 in
let np2 = to_float_array p2 in
let np3 = to_float_array p3 in
let r = glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN np0 np1 np2 np3 in
let _ = copy_word_array np0 p0 in
let _ = copy_float_array np1 p1 in
let _ = copy_float_array np2 p2 in
let _ = copy_float_array np3 p3 in
r

external glReplacementCodeuiTexCoord2fVertex3fSUN: int -> float -> float -> float -> float -> float -> unit = "glstub_glReplacementCodeuiTexCoord2fVertex3fSUN_byte" "glstub_glReplacementCodeuiTexCoord2fVertex3fSUN"

external glReplacementCodeuiTexCoord2fVertex3fvSUN: word_array -> float_array -> float_array -> unit = "glstub_glReplacementCodeuiTexCoord2fVertex3fvSUN" "glstub_glReplacementCodeuiTexCoord2fVertex3fvSUN"
let glReplacementCodeuiTexCoord2fVertex3fvSUN p0 p1 p2 =
let np0 = to_word_array p0 in
let np1 = to_float_array p1 in
let np2 = to_float_array p2 in
let r = glReplacementCodeuiTexCoord2fVertex3fvSUN np0 np1 np2 in
let _ = copy_word_array np0 p0 in
let _ = copy_float_array np1 p1 in
let _ = copy_float_array np2 p2 in
r

external glReplacementCodeuiVertex3fSUN: int -> float -> float -> float -> unit = "glstub_glReplacementCodeuiVertex3fSUN" "glstub_glReplacementCodeuiVertex3fSUN"

external glReplacementCodeuiVertex3fvSUN: word_array -> float_array -> unit = "glstub_glReplacementCodeuiVertex3fvSUN" "glstub_glReplacementCodeuiVertex3fvSUN"
let glReplacementCodeuiVertex3fvSUN p0 p1 =
let np0 = to_word_array p0 in
let np1 = to_float_array p1 in
let r = glReplacementCodeuiVertex3fvSUN np0 np1 in
let _ = copy_word_array np0 p0 in
let _ = copy_float_array np1 p1 in
r


external glReplacementCodeuivSUN: word_array -> unit = "glstub_glReplacementCodeuivSUN" "glstub_glReplacementCodeuivSUN"
let glReplacementCodeuivSUN p0 =
let np0 = to_word_array p0 in
let r = glReplacementCodeuivSUN np0 in
let _ = copy_word_array np0 p0 in
r

external glReplacementCodeusSUN: int -> unit = "glstub_glReplacementCodeusSUN" "glstub_glReplacementCodeusSUN"

external glReplacementCodeusvSUN: ushort_array -> unit = "glstub_glReplacementCodeusvSUN" "glstub_glReplacementCodeusvSUN"
let glReplacementCodeusvSUN p0 =
let np0 = to_ushort_array p0 in
let r = glReplacementCodeusvSUN np0 in
let _ = copy_ushort_array np0 p0 in
r


external glRequestResidentProgramsNV: int -> word_array -> unit = "glstub_glRequestResidentProgramsNV" "glstub_glRequestResidentProgramsNV"
let glRequestResidentProgramsNV p0 p1 =
let np1 = to_word_array p1 in
let r = glRequestResidentProgramsNV p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glResetHistogram: int -> unit = "glstub_glResetHistogram" "glstub_glResetHistogram"
external glResetHistogramEXT: int -> unit = "glstub_glResetHistogramEXT" "glstub_glResetHistogramEXT"
external glResetMinmax: int -> unit = "glstub_glResetMinmax" "glstub_glResetMinmax"
external glResetMinmaxEXT: int -> unit = "glstub_glResetMinmaxEXT" "glstub_glResetMinmaxEXT"
external glResizeBuffersMESA: unit -> unit = "glstub_glResizeBuffersMESA" "glstub_glResizeBuffersMESA"
external glRotated: float -> float -> float -> float -> unit = "glstub_glRotated" "glstub_glRotated"
external glRotatef: float -> float -> float -> float -> unit = "glstub_glRotatef" "glstub_glRotatef"
external glSampleCoverage: float -> bool -> unit = "glstub_glSampleCoverage" "glstub_glSampleCoverage"
external glSampleCoverageARB: float -> bool -> unit = "glstub_glSampleCoverageARB" "glstub_glSampleCoverageARB"
external glSampleMapATI: int -> int -> int -> unit = "glstub_glSampleMapATI" "glstub_glSampleMapATI"
external glSampleMaskEXT: float -> bool -> unit = "glstub_glSampleMaskEXT" "glstub_glSampleMaskEXT"
external glSampleMaskSGIS: float -> bool -> unit = "glstub_glSampleMaskSGIS" "glstub_glSampleMaskSGIS"
external glSamplePatternEXT: int -> unit = "glstub_glSamplePatternEXT" "glstub_glSamplePatternEXT"
external glSamplePatternSGIS: int -> unit = "glstub_glSamplePatternSGIS" "glstub_glSamplePatternSGIS"
external glScaled: float -> float -> float -> unit = "glstub_glScaled" "glstub_glScaled"
external glScalef: float -> float -> float -> unit = "glstub_glScalef" "glstub_glScalef"
external glScissor: int -> int -> int -> int -> unit = "glstub_glScissor" "glstub_glScissor"
external glSecondaryColor3b: int -> int -> int -> unit = "glstub_glSecondaryColor3b" "glstub_glSecondaryColor3b"
external glSecondaryColor3bEXT: int -> int -> int -> unit = "glstub_glSecondaryColor3bEXT" "glstub_glSecondaryColor3bEXT"

external glSecondaryColor3bv: byte_array -> unit = "glstub_glSecondaryColor3bv" "glstub_glSecondaryColor3bv"
let glSecondaryColor3bv p0 =
let np0 = to_byte_array p0 in
let r = glSecondaryColor3bv np0 in
r


external glSecondaryColor3bvEXT: byte_array -> unit = "glstub_glSecondaryColor3bvEXT" "glstub_glSecondaryColor3bvEXT"
let glSecondaryColor3bvEXT p0 =
let np0 = to_byte_array p0 in
let r = glSecondaryColor3bvEXT np0 in
r

external glSecondaryColor3d: float -> float -> float -> unit = "glstub_glSecondaryColor3d" "glstub_glSecondaryColor3d"
external glSecondaryColor3dEXT: float -> float -> float -> unit = "glstub_glSecondaryColor3dEXT" "glstub_glSecondaryColor3dEXT"
external glSecondaryColor3dv: float array -> unit = "glstub_glSecondaryColor3dv" "glstub_glSecondaryColor3dv"
external glSecondaryColor3dvEXT: float array -> unit = "glstub_glSecondaryColor3dvEXT" "glstub_glSecondaryColor3dvEXT"
external glSecondaryColor3f: float -> float -> float -> unit = "glstub_glSecondaryColor3f" "glstub_glSecondaryColor3f"
external glSecondaryColor3fEXT: float -> float -> float -> unit = "glstub_glSecondaryColor3fEXT" "glstub_glSecondaryColor3fEXT"

external glSecondaryColor3fv: float_array -> unit = "glstub_glSecondaryColor3fv" "glstub_glSecondaryColor3fv"
let glSecondaryColor3fv p0 =
let np0 = to_float_array p0 in
let r = glSecondaryColor3fv np0 in
r


external glSecondaryColor3fvEXT: float_array -> unit = "glstub_glSecondaryColor3fvEXT" "glstub_glSecondaryColor3fvEXT"
let glSecondaryColor3fvEXT p0 =
let np0 = to_float_array p0 in
let r = glSecondaryColor3fvEXT np0 in
r

external glSecondaryColor3hNV: int -> int -> int -> unit = "glstub_glSecondaryColor3hNV" "glstub_glSecondaryColor3hNV"

external glSecondaryColor3hvNV: ushort_array -> unit = "glstub_glSecondaryColor3hvNV" "glstub_glSecondaryColor3hvNV"
let glSecondaryColor3hvNV p0 =
let np0 = to_ushort_array p0 in
let r = glSecondaryColor3hvNV np0 in
let _ = copy_ushort_array np0 p0 in
r

external glSecondaryColor3i: int -> int -> int -> unit = "glstub_glSecondaryColor3i" "glstub_glSecondaryColor3i"
external glSecondaryColor3iEXT: int -> int -> int -> unit = "glstub_glSecondaryColor3iEXT" "glstub_glSecondaryColor3iEXT"

external glSecondaryColor3iv: word_array -> unit = "glstub_glSecondaryColor3iv" "glstub_glSecondaryColor3iv"
let glSecondaryColor3iv p0 =
let np0 = to_word_array p0 in
let r = glSecondaryColor3iv np0 in
r


external glSecondaryColor3ivEXT: word_array -> unit = "glstub_glSecondaryColor3ivEXT" "glstub_glSecondaryColor3ivEXT"
let glSecondaryColor3ivEXT p0 =
let np0 = to_word_array p0 in
let r = glSecondaryColor3ivEXT np0 in
r

external glSecondaryColor3s: int -> int -> int -> unit = "glstub_glSecondaryColor3s" "glstub_glSecondaryColor3s"
external glSecondaryColor3sEXT: int -> int -> int -> unit = "glstub_glSecondaryColor3sEXT" "glstub_glSecondaryColor3sEXT"

external glSecondaryColor3sv: short_array -> unit = "glstub_glSecondaryColor3sv" "glstub_glSecondaryColor3sv"
let glSecondaryColor3sv p0 =
let np0 = to_short_array p0 in
let r = glSecondaryColor3sv np0 in
r


external glSecondaryColor3svEXT: short_array -> unit = "glstub_glSecondaryColor3svEXT" "glstub_glSecondaryColor3svEXT"
let glSecondaryColor3svEXT p0 =
let np0 = to_short_array p0 in
let r = glSecondaryColor3svEXT np0 in
r

external glSecondaryColor3ub: int -> int -> int -> unit = "glstub_glSecondaryColor3ub" "glstub_glSecondaryColor3ub"
external glSecondaryColor3ubEXT: int -> int -> int -> unit = "glstub_glSecondaryColor3ubEXT" "glstub_glSecondaryColor3ubEXT"

external glSecondaryColor3ubv: ubyte_array -> unit = "glstub_glSecondaryColor3ubv" "glstub_glSecondaryColor3ubv"
let glSecondaryColor3ubv p0 =
let np0 = to_ubyte_array p0 in
let r = glSecondaryColor3ubv np0 in
r


external glSecondaryColor3ubvEXT: ubyte_array -> unit = "glstub_glSecondaryColor3ubvEXT" "glstub_glSecondaryColor3ubvEXT"
let glSecondaryColor3ubvEXT p0 =
let np0 = to_ubyte_array p0 in
let r = glSecondaryColor3ubvEXT np0 in
r

external glSecondaryColor3ui: int -> int -> int -> unit = "glstub_glSecondaryColor3ui" "glstub_glSecondaryColor3ui"
external glSecondaryColor3uiEXT: int -> int -> int -> unit = "glstub_glSecondaryColor3uiEXT" "glstub_glSecondaryColor3uiEXT"

external glSecondaryColor3uiv: word_array -> unit = "glstub_glSecondaryColor3uiv" "glstub_glSecondaryColor3uiv"
let glSecondaryColor3uiv p0 =
let np0 = to_word_array p0 in
let r = glSecondaryColor3uiv np0 in
r


external glSecondaryColor3uivEXT: word_array -> unit = "glstub_glSecondaryColor3uivEXT" "glstub_glSecondaryColor3uivEXT"
let glSecondaryColor3uivEXT p0 =
let np0 = to_word_array p0 in
let r = glSecondaryColor3uivEXT np0 in
r

external glSecondaryColor3us: int -> int -> int -> unit = "glstub_glSecondaryColor3us" "glstub_glSecondaryColor3us"
external glSecondaryColor3usEXT: int -> int -> int -> unit = "glstub_glSecondaryColor3usEXT" "glstub_glSecondaryColor3usEXT"

external glSecondaryColor3usv: ushort_array -> unit = "glstub_glSecondaryColor3usv" "glstub_glSecondaryColor3usv"
let glSecondaryColor3usv p0 =
let np0 = to_ushort_array p0 in
let r = glSecondaryColor3usv np0 in
r


external glSecondaryColor3usvEXT: ushort_array -> unit = "glstub_glSecondaryColor3usvEXT" "glstub_glSecondaryColor3usvEXT"
let glSecondaryColor3usvEXT p0 =
let np0 = to_ushort_array p0 in
let r = glSecondaryColor3usvEXT np0 in
r

external glSecondaryColorPointer: int -> int -> int -> 'a -> unit = "glstub_glSecondaryColorPointer" "glstub_glSecondaryColorPointer"
external glSecondaryColorPointerEXT: int -> int -> int -> 'a -> unit = "glstub_glSecondaryColorPointerEXT" "glstub_glSecondaryColorPointerEXT"
external glSecondaryColorPointerListIBM: int -> int -> int -> 'a -> int -> unit = "glstub_glSecondaryColorPointerListIBM" "glstub_glSecondaryColorPointerListIBM"

external glSelectBuffer: int -> word_array -> unit = "glstub_glSelectBuffer" "glstub_glSelectBuffer"
let glSelectBuffer p0 p1 =
let np1 = to_word_array p1 in
let r = glSelectBuffer p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glSeparableFilter2D: int -> int -> int -> int -> int -> int -> 'a -> 'a -> unit = "glstub_glSeparableFilter2D_byte" "glstub_glSeparableFilter2D"
external glSeparableFilter2DEXT: int -> int -> int -> int -> int -> int -> 'a -> 'a -> unit = "glstub_glSeparableFilter2DEXT_byte" "glstub_glSeparableFilter2DEXT"
external glSetFenceAPPLE: int -> unit = "glstub_glSetFenceAPPLE" "glstub_glSetFenceAPPLE"
external glSetFenceNV: int -> int -> unit = "glstub_glSetFenceNV" "glstub_glSetFenceNV"

external glSetFragmentShaderConstantATI: int -> float_array -> unit = "glstub_glSetFragmentShaderConstantATI" "glstub_glSetFragmentShaderConstantATI"
let glSetFragmentShaderConstantATI p0 p1 =
let np1 = to_float_array p1 in
let r = glSetFragmentShaderConstantATI p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glSetInvariantEXT: int -> int -> 'a -> unit = "glstub_glSetInvariantEXT" "glstub_glSetInvariantEXT"
external glSetLocalConstantEXT: int -> int -> 'a -> unit = "glstub_glSetLocalConstantEXT" "glstub_glSetLocalConstantEXT"
external glShadeModel: int -> unit = "glstub_glShadeModel" "glstub_glShadeModel"
external glShaderOp1EXT: int -> int -> int -> unit = "glstub_glShaderOp1EXT" "glstub_glShaderOp1EXT"
external glShaderOp2EXT: int -> int -> int -> int -> unit = "glstub_glShaderOp2EXT" "glstub_glShaderOp2EXT"
external glShaderOp3EXT: int -> int -> int -> int -> int -> unit = "glstub_glShaderOp3EXT" "glstub_glShaderOp3EXT"

external glShaderSource: int -> int -> string array -> word_array -> unit = "glstub_glShaderSource" "glstub_glShaderSource"
let glShaderSource p0 p1 p2 p3 =
let np3 = to_word_array p3 in
let r = glShaderSource p0 p1 p2 np3 in
r


external glShaderSourceARB: int -> int -> string array -> word_array -> unit = "glstub_glShaderSourceARB" "glstub_glShaderSourceARB"
let glShaderSourceARB p0 p1 p2 p3 =
let np3 = to_word_array p3 in
let r = glShaderSourceARB p0 p1 p2 np3 in
let _ = copy_word_array np3 p3 in
r


external glSharpenTexFuncSGIS: int -> int -> float_array -> unit = "glstub_glSharpenTexFuncSGIS" "glstub_glSharpenTexFuncSGIS"
let glSharpenTexFuncSGIS p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glSharpenTexFuncSGIS p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glSpriteParameterfSGIX: int -> float -> unit = "glstub_glSpriteParameterfSGIX" "glstub_glSpriteParameterfSGIX"

external glSpriteParameterfvSGIX: int -> float_array -> unit = "glstub_glSpriteParameterfvSGIX" "glstub_glSpriteParameterfvSGIX"
let glSpriteParameterfvSGIX p0 p1 =
let np1 = to_float_array p1 in
let r = glSpriteParameterfvSGIX p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glSpriteParameteriSGIX: int -> int -> unit = "glstub_glSpriteParameteriSGIX" "glstub_glSpriteParameteriSGIX"

external glSpriteParameterivSGIX: int -> word_array -> unit = "glstub_glSpriteParameterivSGIX" "glstub_glSpriteParameterivSGIX"
let glSpriteParameterivSGIX p0 p1 =
let np1 = to_word_array p1 in
let r = glSpriteParameterivSGIX p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glStencilFunc: int -> int -> int -> unit = "glstub_glStencilFunc" "glstub_glStencilFunc"
external glStencilFuncSeparate: int -> int -> int -> int -> unit = "glstub_glStencilFuncSeparate" "glstub_glStencilFuncSeparate"
external glStencilFuncSeparateATI: int -> int -> int -> int -> unit = "glstub_glStencilFuncSeparateATI" "glstub_glStencilFuncSeparateATI"
external glStencilMask: int -> unit = "glstub_glStencilMask" "glstub_glStencilMask"
external glStencilMaskSeparate: int -> int -> unit = "glstub_glStencilMaskSeparate" "glstub_glStencilMaskSeparate"
external glStencilOp: int -> int -> int -> unit = "glstub_glStencilOp" "glstub_glStencilOp"
external glStencilOpSeparate: int -> int -> int -> int -> unit = "glstub_glStencilOpSeparate" "glstub_glStencilOpSeparate"
external glStencilOpSeparateATI: int -> int -> int -> int -> unit = "glstub_glStencilOpSeparateATI" "glstub_glStencilOpSeparateATI"
external glStringMarkerGREMEDY: int -> 'a -> unit = "glstub_glStringMarkerGREMEDY" "glstub_glStringMarkerGREMEDY"
external glSwizzleEXT: int -> int -> int -> int -> int -> int -> unit = "glstub_glSwizzleEXT_byte" "glstub_glSwizzleEXT"
external glTagSampleBufferSGIX: unit -> unit = "glstub_glTagSampleBufferSGIX" "glstub_glTagSampleBufferSGIX"
external glTangentPointerEXT: int -> int -> 'a -> unit = "glstub_glTangentPointerEXT" "glstub_glTangentPointerEXT"
external glTbufferMask3DFX: int -> unit = "glstub_glTbufferMask3DFX" "glstub_glTbufferMask3DFX"
external glTestFenceAPPLE: int -> bool = "glstub_glTestFenceAPPLE" "glstub_glTestFenceAPPLE"
external glTestFenceNV: int -> bool = "glstub_glTestFenceNV" "glstub_glTestFenceNV"
external glTestObjectAPPLE: int -> int -> bool = "glstub_glTestObjectAPPLE" "glstub_glTestObjectAPPLE"
external glTexBufferEXT: int -> int -> int -> unit = "glstub_glTexBufferEXT" "glstub_glTexBufferEXT"

external glTexBumpParameterfvATI: int -> float_array -> unit = "glstub_glTexBumpParameterfvATI" "glstub_glTexBumpParameterfvATI"
let glTexBumpParameterfvATI p0 p1 =
let np1 = to_float_array p1 in
let r = glTexBumpParameterfvATI p0 np1 in
let _ = copy_float_array np1 p1 in
r


external glTexBumpParameterivATI: int -> word_array -> unit = "glstub_glTexBumpParameterivATI" "glstub_glTexBumpParameterivATI"
let glTexBumpParameterivATI p0 p1 =
let np1 = to_word_array p1 in
let r = glTexBumpParameterivATI p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glTexCoord1d: float -> unit = "glstub_glTexCoord1d" "glstub_glTexCoord1d"
external glTexCoord1dv: float array -> unit = "glstub_glTexCoord1dv" "glstub_glTexCoord1dv"
external glTexCoord1f: float -> unit = "glstub_glTexCoord1f" "glstub_glTexCoord1f"

external glTexCoord1fv: float_array -> unit = "glstub_glTexCoord1fv" "glstub_glTexCoord1fv"
let glTexCoord1fv p0 =
let np0 = to_float_array p0 in
let r = glTexCoord1fv np0 in
r

external glTexCoord1hNV: int -> unit = "glstub_glTexCoord1hNV" "glstub_glTexCoord1hNV"

external glTexCoord1hvNV: ushort_array -> unit = "glstub_glTexCoord1hvNV" "glstub_glTexCoord1hvNV"
let glTexCoord1hvNV p0 =
let np0 = to_ushort_array p0 in
let r = glTexCoord1hvNV np0 in
let _ = copy_ushort_array np0 p0 in
r

external glTexCoord1i: int -> unit = "glstub_glTexCoord1i" "glstub_glTexCoord1i"

external glTexCoord1iv: word_array -> unit = "glstub_glTexCoord1iv" "glstub_glTexCoord1iv"
let glTexCoord1iv p0 =
let np0 = to_word_array p0 in
let r = glTexCoord1iv np0 in
r

external glTexCoord1s: int -> unit = "glstub_glTexCoord1s" "glstub_glTexCoord1s"

external glTexCoord1sv: short_array -> unit = "glstub_glTexCoord1sv" "glstub_glTexCoord1sv"
let glTexCoord1sv p0 =
let np0 = to_short_array p0 in
let r = glTexCoord1sv np0 in
r

external glTexCoord2d: float -> float -> unit = "glstub_glTexCoord2d" "glstub_glTexCoord2d"
external glTexCoord2dv: float array -> unit = "glstub_glTexCoord2dv" "glstub_glTexCoord2dv"
external glTexCoord2f: float -> float -> unit = "glstub_glTexCoord2f" "glstub_glTexCoord2f"
external glTexCoord2fColor3fVertex3fSUN: float -> float -> float -> float -> float -> float -> float -> float -> unit = "glstub_glTexCoord2fColor3fVertex3fSUN_byte" "glstub_glTexCoord2fColor3fVertex3fSUN"

external glTexCoord2fColor3fVertex3fvSUN: float_array -> float_array -> float_array -> unit = "glstub_glTexCoord2fColor3fVertex3fvSUN" "glstub_glTexCoord2fColor3fVertex3fvSUN"
let glTexCoord2fColor3fVertex3fvSUN p0 p1 p2 =
let np0 = to_float_array p0 in
let np1 = to_float_array p1 in
let np2 = to_float_array p2 in
let r = glTexCoord2fColor3fVertex3fvSUN np0 np1 np2 in
let _ = copy_float_array np0 p0 in
let _ = copy_float_array np1 p1 in
let _ = copy_float_array np2 p2 in
r

external glTexCoord2fColor4fNormal3fVertex3fSUN: float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> unit = "glstub_glTexCoord2fColor4fNormal3fVertex3fSUN_byte" "glstub_glTexCoord2fColor4fNormal3fVertex3fSUN"

external glTexCoord2fColor4fNormal3fVertex3fvSUN: float_array -> float_array -> float_array -> float_array -> unit = "glstub_glTexCoord2fColor4fNormal3fVertex3fvSUN" "glstub_glTexCoord2fColor4fNormal3fVertex3fvSUN"
let glTexCoord2fColor4fNormal3fVertex3fvSUN p0 p1 p2 p3 =
let np0 = to_float_array p0 in
let np1 = to_float_array p1 in
let np2 = to_float_array p2 in
let np3 = to_float_array p3 in
let r = glTexCoord2fColor4fNormal3fVertex3fvSUN np0 np1 np2 np3 in
let _ = copy_float_array np0 p0 in
let _ = copy_float_array np1 p1 in
let _ = copy_float_array np2 p2 in
let _ = copy_float_array np3 p3 in
r

external glTexCoord2fColor4ubVertex3fSUN: float -> float -> int -> int -> int -> int -> float -> float -> float -> unit = "glstub_glTexCoord2fColor4ubVertex3fSUN_byte" "glstub_glTexCoord2fColor4ubVertex3fSUN"

external glTexCoord2fColor4ubVertex3fvSUN: float_array -> ubyte_array -> float_array -> unit = "glstub_glTexCoord2fColor4ubVertex3fvSUN" "glstub_glTexCoord2fColor4ubVertex3fvSUN"
let glTexCoord2fColor4ubVertex3fvSUN p0 p1 p2 =
let np0 = to_float_array p0 in
let np1 = to_ubyte_array p1 in
let np2 = to_float_array p2 in
let r = glTexCoord2fColor4ubVertex3fvSUN np0 np1 np2 in
let _ = copy_float_array np0 p0 in
let _ = copy_ubyte_array np1 p1 in
let _ = copy_float_array np2 p2 in
r

external glTexCoord2fNormal3fVertex3fSUN: float -> float -> float -> float -> float -> float -> float -> float -> unit = "glstub_glTexCoord2fNormal3fVertex3fSUN_byte" "glstub_glTexCoord2fNormal3fVertex3fSUN"

external glTexCoord2fNormal3fVertex3fvSUN: float_array -> float_array -> float_array -> unit = "glstub_glTexCoord2fNormal3fVertex3fvSUN" "glstub_glTexCoord2fNormal3fVertex3fvSUN"
let glTexCoord2fNormal3fVertex3fvSUN p0 p1 p2 =
let np0 = to_float_array p0 in
let np1 = to_float_array p1 in
let np2 = to_float_array p2 in
let r = glTexCoord2fNormal3fVertex3fvSUN np0 np1 np2 in
let _ = copy_float_array np0 p0 in
let _ = copy_float_array np1 p1 in
let _ = copy_float_array np2 p2 in
r

external glTexCoord2fVertex3fSUN: float -> float -> float -> float -> float -> unit = "glstub_glTexCoord2fVertex3fSUN" "glstub_glTexCoord2fVertex3fSUN"

external glTexCoord2fVertex3fvSUN: float_array -> float_array -> unit = "glstub_glTexCoord2fVertex3fvSUN" "glstub_glTexCoord2fVertex3fvSUN"
let glTexCoord2fVertex3fvSUN p0 p1 =
let np0 = to_float_array p0 in
let np1 = to_float_array p1 in
let r = glTexCoord2fVertex3fvSUN np0 np1 in
let _ = copy_float_array np0 p0 in
let _ = copy_float_array np1 p1 in
r


external glTexCoord2fv: float_array -> unit = "glstub_glTexCoord2fv" "glstub_glTexCoord2fv"
let glTexCoord2fv p0 =
let np0 = to_float_array p0 in
let r = glTexCoord2fv np0 in
r

external glTexCoord2hNV: int -> int -> unit = "glstub_glTexCoord2hNV" "glstub_glTexCoord2hNV"

external glTexCoord2hvNV: ushort_array -> unit = "glstub_glTexCoord2hvNV" "glstub_glTexCoord2hvNV"
let glTexCoord2hvNV p0 =
let np0 = to_ushort_array p0 in
let r = glTexCoord2hvNV np0 in
let _ = copy_ushort_array np0 p0 in
r

external glTexCoord2i: int -> int -> unit = "glstub_glTexCoord2i" "glstub_glTexCoord2i"

external glTexCoord2iv: word_array -> unit = "glstub_glTexCoord2iv" "glstub_glTexCoord2iv"
let glTexCoord2iv p0 =
let np0 = to_word_array p0 in
let r = glTexCoord2iv np0 in
r

external glTexCoord2s: int -> int -> unit = "glstub_glTexCoord2s" "glstub_glTexCoord2s"

external glTexCoord2sv: short_array -> unit = "glstub_glTexCoord2sv" "glstub_glTexCoord2sv"
let glTexCoord2sv p0 =
let np0 = to_short_array p0 in
let r = glTexCoord2sv np0 in
r

external glTexCoord3d: float -> float -> float -> unit = "glstub_glTexCoord3d" "glstub_glTexCoord3d"
external glTexCoord3dv: float array -> unit = "glstub_glTexCoord3dv" "glstub_glTexCoord3dv"
external glTexCoord3f: float -> float -> float -> unit = "glstub_glTexCoord3f" "glstub_glTexCoord3f"

external glTexCoord3fv: float_array -> unit = "glstub_glTexCoord3fv" "glstub_glTexCoord3fv"
let glTexCoord3fv p0 =
let np0 = to_float_array p0 in
let r = glTexCoord3fv np0 in
r

external glTexCoord3hNV: int -> int -> int -> unit = "glstub_glTexCoord3hNV" "glstub_glTexCoord3hNV"

external glTexCoord3hvNV: ushort_array -> unit = "glstub_glTexCoord3hvNV" "glstub_glTexCoord3hvNV"
let glTexCoord3hvNV p0 =
let np0 = to_ushort_array p0 in
let r = glTexCoord3hvNV np0 in
let _ = copy_ushort_array np0 p0 in
r

external glTexCoord3i: int -> int -> int -> unit = "glstub_glTexCoord3i" "glstub_glTexCoord3i"

external glTexCoord3iv: word_array -> unit = "glstub_glTexCoord3iv" "glstub_glTexCoord3iv"
let glTexCoord3iv p0 =
let np0 = to_word_array p0 in
let r = glTexCoord3iv np0 in
r

external glTexCoord3s: int -> int -> int -> unit = "glstub_glTexCoord3s" "glstub_glTexCoord3s"

external glTexCoord3sv: short_array -> unit = "glstub_glTexCoord3sv" "glstub_glTexCoord3sv"
let glTexCoord3sv p0 =
let np0 = to_short_array p0 in
let r = glTexCoord3sv np0 in
r

external glTexCoord4d: float -> float -> float -> float -> unit = "glstub_glTexCoord4d" "glstub_glTexCoord4d"
external glTexCoord4dv: float array -> unit = "glstub_glTexCoord4dv" "glstub_glTexCoord4dv"
external glTexCoord4f: float -> float -> float -> float -> unit = "glstub_glTexCoord4f" "glstub_glTexCoord4f"
external glTexCoord4fColor4fNormal3fVertex4fSUN: float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> float -> unit = "glstub_glTexCoord4fColor4fNormal3fVertex4fSUN_byte" "glstub_glTexCoord4fColor4fNormal3fVertex4fSUN"

external glTexCoord4fColor4fNormal3fVertex4fvSUN: float_array -> float_array -> float_array -> float_array -> unit = "glstub_glTexCoord4fColor4fNormal3fVertex4fvSUN" "glstub_glTexCoord4fColor4fNormal3fVertex4fvSUN"
let glTexCoord4fColor4fNormal3fVertex4fvSUN p0 p1 p2 p3 =
let np0 = to_float_array p0 in
let np1 = to_float_array p1 in
let np2 = to_float_array p2 in
let np3 = to_float_array p3 in
let r = glTexCoord4fColor4fNormal3fVertex4fvSUN np0 np1 np2 np3 in
let _ = copy_float_array np0 p0 in
let _ = copy_float_array np1 p1 in
let _ = copy_float_array np2 p2 in
let _ = copy_float_array np3 p3 in
r

external glTexCoord4fVertex4fSUN: float -> float -> float -> float -> float -> float -> float -> float -> unit = "glstub_glTexCoord4fVertex4fSUN_byte" "glstub_glTexCoord4fVertex4fSUN"

external glTexCoord4fVertex4fvSUN: float_array -> float_array -> unit = "glstub_glTexCoord4fVertex4fvSUN" "glstub_glTexCoord4fVertex4fvSUN"
let glTexCoord4fVertex4fvSUN p0 p1 =
let np0 = to_float_array p0 in
let np1 = to_float_array p1 in
let r = glTexCoord4fVertex4fvSUN np0 np1 in
let _ = copy_float_array np0 p0 in
let _ = copy_float_array np1 p1 in
r


external glTexCoord4fv: float_array -> unit = "glstub_glTexCoord4fv" "glstub_glTexCoord4fv"
let glTexCoord4fv p0 =
let np0 = to_float_array p0 in
let r = glTexCoord4fv np0 in
r

external glTexCoord4hNV: int -> int -> int -> int -> unit = "glstub_glTexCoord4hNV" "glstub_glTexCoord4hNV"

external glTexCoord4hvNV: ushort_array -> unit = "glstub_glTexCoord4hvNV" "glstub_glTexCoord4hvNV"
let glTexCoord4hvNV p0 =
let np0 = to_ushort_array p0 in
let r = glTexCoord4hvNV np0 in
let _ = copy_ushort_array np0 p0 in
r

external glTexCoord4i: int -> int -> int -> int -> unit = "glstub_glTexCoord4i" "glstub_glTexCoord4i"

external glTexCoord4iv: word_array -> unit = "glstub_glTexCoord4iv" "glstub_glTexCoord4iv"
let glTexCoord4iv p0 =
let np0 = to_word_array p0 in
let r = glTexCoord4iv np0 in
r

external glTexCoord4s: int -> int -> int -> int -> unit = "glstub_glTexCoord4s" "glstub_glTexCoord4s"

external glTexCoord4sv: short_array -> unit = "glstub_glTexCoord4sv" "glstub_glTexCoord4sv"
let glTexCoord4sv p0 =
let np0 = to_short_array p0 in
let r = glTexCoord4sv np0 in
r

external glTexCoordPointer: int -> int -> int -> 'a -> unit = "glstub_glTexCoordPointer" "glstub_glTexCoordPointer"
external glTexCoordPointerEXT: int -> int -> int -> int -> 'a -> unit = "glstub_glTexCoordPointerEXT" "glstub_glTexCoordPointerEXT"
external glTexCoordPointerListIBM: int -> int -> int -> 'a -> int -> unit = "glstub_glTexCoordPointerListIBM" "glstub_glTexCoordPointerListIBM"
external glTexCoordPointervINTEL: int -> int -> 'a -> unit = "glstub_glTexCoordPointervINTEL" "glstub_glTexCoordPointervINTEL"
external glTexEnvf: int -> int -> float -> unit = "glstub_glTexEnvf" "glstub_glTexEnvf"

external glTexEnvfv: int -> int -> float_array -> unit = "glstub_glTexEnvfv" "glstub_glTexEnvfv"
let glTexEnvfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glTexEnvfv p0 p1 np2 in
r

external glTexEnvi: int -> int -> int -> unit = "glstub_glTexEnvi" "glstub_glTexEnvi"

external glTexEnviv: int -> int -> word_array -> unit = "glstub_glTexEnviv" "glstub_glTexEnviv"
let glTexEnviv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glTexEnviv p0 p1 np2 in
r


external glTexFilterFuncSGIS: int -> int -> int -> float_array -> unit = "glstub_glTexFilterFuncSGIS" "glstub_glTexFilterFuncSGIS"
let glTexFilterFuncSGIS p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glTexFilterFuncSGIS p0 p1 p2 np3 in
let _ = copy_float_array np3 p3 in
r

external glTexGend: int -> int -> float -> unit = "glstub_glTexGend" "glstub_glTexGend"
external glTexGendv: int -> int -> float array -> unit = "glstub_glTexGendv" "glstub_glTexGendv"
external glTexGenf: int -> int -> float -> unit = "glstub_glTexGenf" "glstub_glTexGenf"

external glTexGenfv: int -> int -> float_array -> unit = "glstub_glTexGenfv" "glstub_glTexGenfv"
let glTexGenfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glTexGenfv p0 p1 np2 in
r

external glTexGeni: int -> int -> int -> unit = "glstub_glTexGeni" "glstub_glTexGeni"

external glTexGeniv: int -> int -> word_array -> unit = "glstub_glTexGeniv" "glstub_glTexGeniv"
let glTexGeniv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glTexGeniv p0 p1 np2 in
r

external glTexImage1D: int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glTexImage1D_byte" "glstub_glTexImage1D"
external glTexImage2D: int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glTexImage2D_byte" "glstub_glTexImage2D"
external glTexImage3D: int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glTexImage3D_byte" "glstub_glTexImage3D"
external glTexImage3DEXT: int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glTexImage3DEXT_byte" "glstub_glTexImage3DEXT"
external glTexImage4DSGIS: int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glTexImage4DSGIS_byte" "glstub_glTexImage4DSGIS"

external glTexParameterIivEXT: int -> int -> word_array -> unit = "glstub_glTexParameterIivEXT" "glstub_glTexParameterIivEXT"
let glTexParameterIivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glTexParameterIivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r


external glTexParameterIuivEXT: int -> int -> word_array -> unit = "glstub_glTexParameterIuivEXT" "glstub_glTexParameterIuivEXT"
let glTexParameterIuivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glTexParameterIuivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glTexParameterf: int -> int -> float -> unit = "glstub_glTexParameterf" "glstub_glTexParameterf"

external glTexParameterfv: int -> int -> float_array -> unit = "glstub_glTexParameterfv" "glstub_glTexParameterfv"
let glTexParameterfv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glTexParameterfv p0 p1 np2 in
r

external glTexParameteri: int -> int -> int -> unit = "glstub_glTexParameteri" "glstub_glTexParameteri"

external glTexParameteriv: int -> int -> word_array -> unit = "glstub_glTexParameteriv" "glstub_glTexParameteriv"
let glTexParameteriv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glTexParameteriv p0 p1 np2 in
r

external glTexScissorFuncINTEL: int -> int -> int -> unit = "glstub_glTexScissorFuncINTEL" "glstub_glTexScissorFuncINTEL"
external glTexScissorINTEL: int -> float -> float -> unit = "glstub_glTexScissorINTEL" "glstub_glTexScissorINTEL"
external glTexSubImage1D: int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glTexSubImage1D_byte" "glstub_glTexSubImage1D"
external glTexSubImage1DEXT: int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glTexSubImage1DEXT_byte" "glstub_glTexSubImage1DEXT"
external glTexSubImage2D: int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glTexSubImage2D_byte" "glstub_glTexSubImage2D"
external glTexSubImage2DEXT: int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glTexSubImage2DEXT_byte" "glstub_glTexSubImage2DEXT"
external glTexSubImage3D: int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glTexSubImage3D_byte" "glstub_glTexSubImage3D"
external glTexSubImage3DEXT: int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glTexSubImage3DEXT_byte" "glstub_glTexSubImage3DEXT"
external glTexSubImage4DSGIS: int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit = "glstub_glTexSubImage4DSGIS_byte" "glstub_glTexSubImage4DSGIS"
external glTextureFogSGIX: int -> unit = "glstub_glTextureFogSGIX" "glstub_glTextureFogSGIX"
external glTextureLightEXT: int -> unit = "glstub_glTextureLightEXT" "glstub_glTextureLightEXT"
external glTextureMaterialEXT: int -> int -> unit = "glstub_glTextureMaterialEXT" "glstub_glTextureMaterialEXT"
external glTextureNormalEXT: int -> unit = "glstub_glTextureNormalEXT" "glstub_glTextureNormalEXT"
external glTextureRangeAPPLE: int -> int -> 'a -> unit = "glstub_glTextureRangeAPPLE" "glstub_glTextureRangeAPPLE"
external glTrackMatrixNV: int -> int -> int -> int -> unit = "glstub_glTrackMatrixNV" "glstub_glTrackMatrixNV"

external glTransformFeedbackAttribsNV: int -> word_array -> int -> unit = "glstub_glTransformFeedbackAttribsNV" "glstub_glTransformFeedbackAttribsNV"
let glTransformFeedbackAttribsNV p0 p1 p2 =
let np1 = to_word_array p1 in
let r = glTransformFeedbackAttribsNV p0 np1 p2 in
let _ = copy_word_array np1 p1 in
r


external glTransformFeedbackVaryingsNV: int -> int -> word_array -> int -> unit = "glstub_glTransformFeedbackVaryingsNV" "glstub_glTransformFeedbackVaryingsNV"
let glTransformFeedbackVaryingsNV p0 p1 p2 p3 =
let np2 = to_word_array p2 in
let r = glTransformFeedbackVaryingsNV p0 p1 np2 p3 in
let _ = copy_word_array np2 p2 in
r

external glTranslated: float -> float -> float -> unit = "glstub_glTranslated" "glstub_glTranslated"
external glTranslatef: float -> float -> float -> unit = "glstub_glTranslatef" "glstub_glTranslatef"
external glUniform1f: int -> float -> unit = "glstub_glUniform1f" "glstub_glUniform1f"
external glUniform1fARB: int -> float -> unit = "glstub_glUniform1fARB" "glstub_glUniform1fARB"

external glUniform1fv: int -> int -> float_array -> unit = "glstub_glUniform1fv" "glstub_glUniform1fv"
let glUniform1fv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glUniform1fv p0 p1 np2 in
r


external glUniform1fvARB: int -> int -> float_array -> unit = "glstub_glUniform1fvARB" "glstub_glUniform1fvARB"
let glUniform1fvARB p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glUniform1fvARB p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glUniform1i: int -> int -> unit = "glstub_glUniform1i" "glstub_glUniform1i"
external glUniform1iARB: int -> int -> unit = "glstub_glUniform1iARB" "glstub_glUniform1iARB"

external glUniform1iv: int -> int -> word_array -> unit = "glstub_glUniform1iv" "glstub_glUniform1iv"
let glUniform1iv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glUniform1iv p0 p1 np2 in
r


external glUniform1ivARB: int -> int -> word_array -> unit = "glstub_glUniform1ivARB" "glstub_glUniform1ivARB"
let glUniform1ivARB p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glUniform1ivARB p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glUniform1uiEXT: int -> int -> unit = "glstub_glUniform1uiEXT" "glstub_glUniform1uiEXT"

external glUniform1uivEXT: int -> int -> word_array -> unit = "glstub_glUniform1uivEXT" "glstub_glUniform1uivEXT"
let glUniform1uivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glUniform1uivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glUniform2f: int -> float -> float -> unit = "glstub_glUniform2f" "glstub_glUniform2f"
external glUniform2fARB: int -> float -> float -> unit = "glstub_glUniform2fARB" "glstub_glUniform2fARB"

external glUniform2fv: int -> int -> float_array -> unit = "glstub_glUniform2fv" "glstub_glUniform2fv"
let glUniform2fv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glUniform2fv p0 p1 np2 in
r


external glUniform2fvARB: int -> int -> float_array -> unit = "glstub_glUniform2fvARB" "glstub_glUniform2fvARB"
let glUniform2fvARB p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glUniform2fvARB p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glUniform2i: int -> int -> int -> unit = "glstub_glUniform2i" "glstub_glUniform2i"
external glUniform2iARB: int -> int -> int -> unit = "glstub_glUniform2iARB" "glstub_glUniform2iARB"

external glUniform2iv: int -> int -> word_array -> unit = "glstub_glUniform2iv" "glstub_glUniform2iv"
let glUniform2iv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glUniform2iv p0 p1 np2 in
r


external glUniform2ivARB: int -> int -> word_array -> unit = "glstub_glUniform2ivARB" "glstub_glUniform2ivARB"
let glUniform2ivARB p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glUniform2ivARB p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glUniform2uiEXT: int -> int -> int -> unit = "glstub_glUniform2uiEXT" "glstub_glUniform2uiEXT"

external glUniform2uivEXT: int -> int -> word_array -> unit = "glstub_glUniform2uivEXT" "glstub_glUniform2uivEXT"
let glUniform2uivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glUniform2uivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glUniform3f: int -> float -> float -> float -> unit = "glstub_glUniform3f" "glstub_glUniform3f"
external glUniform3fARB: int -> float -> float -> float -> unit = "glstub_glUniform3fARB" "glstub_glUniform3fARB"

external glUniform3fv: int -> int -> float_array -> unit = "glstub_glUniform3fv" "glstub_glUniform3fv"
let glUniform3fv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glUniform3fv p0 p1 np2 in
r


external glUniform3fvARB: int -> int -> float_array -> unit = "glstub_glUniform3fvARB" "glstub_glUniform3fvARB"
let glUniform3fvARB p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glUniform3fvARB p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glUniform3i: int -> int -> int -> int -> unit = "glstub_glUniform3i" "glstub_glUniform3i"
external glUniform3iARB: int -> int -> int -> int -> unit = "glstub_glUniform3iARB" "glstub_glUniform3iARB"

external glUniform3iv: int -> int -> word_array -> unit = "glstub_glUniform3iv" "glstub_glUniform3iv"
let glUniform3iv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glUniform3iv p0 p1 np2 in
r


external glUniform3ivARB: int -> int -> word_array -> unit = "glstub_glUniform3ivARB" "glstub_glUniform3ivARB"
let glUniform3ivARB p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glUniform3ivARB p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glUniform3uiEXT: int -> int -> int -> int -> unit = "glstub_glUniform3uiEXT" "glstub_glUniform3uiEXT"

external glUniform3uivEXT: int -> int -> word_array -> unit = "glstub_glUniform3uivEXT" "glstub_glUniform3uivEXT"
let glUniform3uivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glUniform3uivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glUniform4f: int -> float -> float -> float -> float -> unit = "glstub_glUniform4f" "glstub_glUniform4f"
external glUniform4fARB: int -> float -> float -> float -> float -> unit = "glstub_glUniform4fARB" "glstub_glUniform4fARB"

external glUniform4fv: int -> int -> float_array -> unit = "glstub_glUniform4fv" "glstub_glUniform4fv"
let glUniform4fv p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glUniform4fv p0 p1 np2 in
r


external glUniform4fvARB: int -> int -> float_array -> unit = "glstub_glUniform4fvARB" "glstub_glUniform4fvARB"
let glUniform4fvARB p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glUniform4fvARB p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r

external glUniform4i: int -> int -> int -> int -> int -> unit = "glstub_glUniform4i" "glstub_glUniform4i"
external glUniform4iARB: int -> int -> int -> int -> int -> unit = "glstub_glUniform4iARB" "glstub_glUniform4iARB"

external glUniform4iv: int -> int -> word_array -> unit = "glstub_glUniform4iv" "glstub_glUniform4iv"
let glUniform4iv p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glUniform4iv p0 p1 np2 in
r


external glUniform4ivARB: int -> int -> word_array -> unit = "glstub_glUniform4ivARB" "glstub_glUniform4ivARB"
let glUniform4ivARB p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glUniform4ivARB p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glUniform4uiEXT: int -> int -> int -> int -> int -> unit = "glstub_glUniform4uiEXT" "glstub_glUniform4uiEXT"

external glUniform4uivEXT: int -> int -> word_array -> unit = "glstub_glUniform4uivEXT" "glstub_glUniform4uivEXT"
let glUniform4uivEXT p0 p1 p2 =
let np2 = to_word_array p2 in
let r = glUniform4uivEXT p0 p1 np2 in
let _ = copy_word_array np2 p2 in
r

external glUniformBufferEXT: int -> int -> int -> unit = "glstub_glUniformBufferEXT" "glstub_glUniformBufferEXT"

external glUniformMatrix2fv: int -> int -> bool -> float_array -> unit = "glstub_glUniformMatrix2fv" "glstub_glUniformMatrix2fv"
let glUniformMatrix2fv p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glUniformMatrix2fv p0 p1 p2 np3 in
r


external glUniformMatrix2fvARB: int -> int -> bool -> float_array -> unit = "glstub_glUniformMatrix2fvARB" "glstub_glUniformMatrix2fvARB"
let glUniformMatrix2fvARB p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glUniformMatrix2fvARB p0 p1 p2 np3 in
let _ = copy_float_array np3 p3 in
r


external glUniformMatrix2x3fv: int -> int -> bool -> float_array -> unit = "glstub_glUniformMatrix2x3fv" "glstub_glUniformMatrix2x3fv"
let glUniformMatrix2x3fv p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glUniformMatrix2x3fv p0 p1 p2 np3 in
r


external glUniformMatrix2x4fv: int -> int -> bool -> float_array -> unit = "glstub_glUniformMatrix2x4fv" "glstub_glUniformMatrix2x4fv"
let glUniformMatrix2x4fv p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glUniformMatrix2x4fv p0 p1 p2 np3 in
r


external glUniformMatrix3fv: int -> int -> bool -> float_array -> unit = "glstub_glUniformMatrix3fv" "glstub_glUniformMatrix3fv"
let glUniformMatrix3fv p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glUniformMatrix3fv p0 p1 p2 np3 in
r


external glUniformMatrix3fvARB: int -> int -> bool -> float_array -> unit = "glstub_glUniformMatrix3fvARB" "glstub_glUniformMatrix3fvARB"
let glUniformMatrix3fvARB p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glUniformMatrix3fvARB p0 p1 p2 np3 in
let _ = copy_float_array np3 p3 in
r


external glUniformMatrix3x2fv: int -> int -> bool -> float_array -> unit = "glstub_glUniformMatrix3x2fv" "glstub_glUniformMatrix3x2fv"
let glUniformMatrix3x2fv p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glUniformMatrix3x2fv p0 p1 p2 np3 in
r


external glUniformMatrix3x4fv: int -> int -> bool -> float_array -> unit = "glstub_glUniformMatrix3x4fv" "glstub_glUniformMatrix3x4fv"
let glUniformMatrix3x4fv p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glUniformMatrix3x4fv p0 p1 p2 np3 in
r


external glUniformMatrix4fv: int -> int -> bool -> float_array -> unit = "glstub_glUniformMatrix4fv" "glstub_glUniformMatrix4fv"
let glUniformMatrix4fv p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glUniformMatrix4fv p0 p1 p2 np3 in
r


external glUniformMatrix4fvARB: int -> int -> bool -> float_array -> unit = "glstub_glUniformMatrix4fvARB" "glstub_glUniformMatrix4fvARB"
let glUniformMatrix4fvARB p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glUniformMatrix4fvARB p0 p1 p2 np3 in
let _ = copy_float_array np3 p3 in
r


external glUniformMatrix4x2fv: int -> int -> bool -> float_array -> unit = "glstub_glUniformMatrix4x2fv" "glstub_glUniformMatrix4x2fv"
let glUniformMatrix4x2fv p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glUniformMatrix4x2fv p0 p1 p2 np3 in
r


external glUniformMatrix4x3fv: int -> int -> bool -> float_array -> unit = "glstub_glUniformMatrix4x3fv" "glstub_glUniformMatrix4x3fv"
let glUniformMatrix4x3fv p0 p1 p2 p3 =
let np3 = to_float_array p3 in
let r = glUniformMatrix4x3fv p0 p1 p2 np3 in
r

external glUnlockArraysEXT: unit -> unit = "glstub_glUnlockArraysEXT" "glstub_glUnlockArraysEXT"
external glUnmapBuffer: int -> bool = "glstub_glUnmapBuffer" "glstub_glUnmapBuffer"
external glUnmapBufferARB: int -> bool = "glstub_glUnmapBufferARB" "glstub_glUnmapBufferARB"
external glUnmapObjectBufferATI: int -> unit = "glstub_glUnmapObjectBufferATI" "glstub_glUnmapObjectBufferATI"
external glUpdateObjectBufferATI: int -> int -> int -> 'a -> int -> unit = "glstub_glUpdateObjectBufferATI" "glstub_glUpdateObjectBufferATI"
external glUseProgram: int -> unit = "glstub_glUseProgram" "glstub_glUseProgram"
external glUseProgramObjectARB: int -> unit = "glstub_glUseProgramObjectARB" "glstub_glUseProgramObjectARB"
external glValidateProgram: int -> unit = "glstub_glValidateProgram" "glstub_glValidateProgram"
external glValidateProgramARB: int -> unit = "glstub_glValidateProgramARB" "glstub_glValidateProgramARB"
external glVariantArrayObjectATI: int -> int -> int -> int -> int -> unit = "glstub_glVariantArrayObjectATI" "glstub_glVariantArrayObjectATI"
external glVariantPointerEXT: int -> int -> int -> 'a -> unit = "glstub_glVariantPointerEXT" "glstub_glVariantPointerEXT"

external glVariantbvEXT: int -> byte_array -> unit = "glstub_glVariantbvEXT" "glstub_glVariantbvEXT"
let glVariantbvEXT p0 p1 =
let np1 = to_byte_array p1 in
let r = glVariantbvEXT p0 np1 in
let _ = copy_byte_array np1 p1 in
r

external glVariantdvEXT: int -> float array -> unit = "glstub_glVariantdvEXT" "glstub_glVariantdvEXT"

external glVariantfvEXT: int -> float_array -> unit = "glstub_glVariantfvEXT" "glstub_glVariantfvEXT"
let glVariantfvEXT p0 p1 =
let np1 = to_float_array p1 in
let r = glVariantfvEXT p0 np1 in
let _ = copy_float_array np1 p1 in
r


external glVariantivEXT: int -> word_array -> unit = "glstub_glVariantivEXT" "glstub_glVariantivEXT"
let glVariantivEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glVariantivEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glVariantsvEXT: int -> short_array -> unit = "glstub_glVariantsvEXT" "glstub_glVariantsvEXT"
let glVariantsvEXT p0 p1 =
let np1 = to_short_array p1 in
let r = glVariantsvEXT p0 np1 in
let _ = copy_short_array np1 p1 in
r


external glVariantubvEXT: int -> ubyte_array -> unit = "glstub_glVariantubvEXT" "glstub_glVariantubvEXT"
let glVariantubvEXT p0 p1 =
let np1 = to_ubyte_array p1 in
let r = glVariantubvEXT p0 np1 in
let _ = copy_ubyte_array np1 p1 in
r


external glVariantuivEXT: int -> word_array -> unit = "glstub_glVariantuivEXT" "glstub_glVariantuivEXT"
let glVariantuivEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glVariantuivEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glVariantusvEXT: int -> ushort_array -> unit = "glstub_glVariantusvEXT" "glstub_glVariantusvEXT"
let glVariantusvEXT p0 p1 =
let np1 = to_ushort_array p1 in
let r = glVariantusvEXT p0 np1 in
let _ = copy_ushort_array np1 p1 in
r

external glVertex2d: float -> float -> unit = "glstub_glVertex2d" "glstub_glVertex2d"
external glVertex2dv: float array -> unit = "glstub_glVertex2dv" "glstub_glVertex2dv"
external glVertex2f: float -> float -> unit = "glstub_glVertex2f" "glstub_glVertex2f"

external glVertex2fv: float_array -> unit = "glstub_glVertex2fv" "glstub_glVertex2fv"
let glVertex2fv p0 =
let np0 = to_float_array p0 in
let r = glVertex2fv np0 in
r

external glVertex2hNV: int -> int -> unit = "glstub_glVertex2hNV" "glstub_glVertex2hNV"

external glVertex2hvNV: ushort_array -> unit = "glstub_glVertex2hvNV" "glstub_glVertex2hvNV"
let glVertex2hvNV p0 =
let np0 = to_ushort_array p0 in
let r = glVertex2hvNV np0 in
let _ = copy_ushort_array np0 p0 in
r

external glVertex2i: int -> int -> unit = "glstub_glVertex2i" "glstub_glVertex2i"

external glVertex2iv: word_array -> unit = "glstub_glVertex2iv" "glstub_glVertex2iv"
let glVertex2iv p0 =
let np0 = to_word_array p0 in
let r = glVertex2iv np0 in
r

external glVertex2s: int -> int -> unit = "glstub_glVertex2s" "glstub_glVertex2s"

external glVertex2sv: short_array -> unit = "glstub_glVertex2sv" "glstub_glVertex2sv"
let glVertex2sv p0 =
let np0 = to_short_array p0 in
let r = glVertex2sv np0 in
r

external glVertex3d: float -> float -> float -> unit = "glstub_glVertex3d" "glstub_glVertex3d"
external glVertex3dv: float array -> unit = "glstub_glVertex3dv" "glstub_glVertex3dv"
external glVertex3f: float -> float -> float -> unit = "glstub_glVertex3f" "glstub_glVertex3f"

external glVertex3fv: float_array -> unit = "glstub_glVertex3fv" "glstub_glVertex3fv"
let glVertex3fv p0 =
let np0 = to_float_array p0 in
let r = glVertex3fv np0 in
r

external glVertex3hNV: int -> int -> int -> unit = "glstub_glVertex3hNV" "glstub_glVertex3hNV"

external glVertex3hvNV: ushort_array -> unit = "glstub_glVertex3hvNV" "glstub_glVertex3hvNV"
let glVertex3hvNV p0 =
let np0 = to_ushort_array p0 in
let r = glVertex3hvNV np0 in
let _ = copy_ushort_array np0 p0 in
r

external glVertex3i: int -> int -> int -> unit = "glstub_glVertex3i" "glstub_glVertex3i"

external glVertex3iv: word_array -> unit = "glstub_glVertex3iv" "glstub_glVertex3iv"
let glVertex3iv p0 =
let np0 = to_word_array p0 in
let r = glVertex3iv np0 in
r

external glVertex3s: int -> int -> int -> unit = "glstub_glVertex3s" "glstub_glVertex3s"

external glVertex3sv: short_array -> unit = "glstub_glVertex3sv" "glstub_glVertex3sv"
let glVertex3sv p0 =
let np0 = to_short_array p0 in
let r = glVertex3sv np0 in
r

external glVertex4d: float -> float -> float -> float -> unit = "glstub_glVertex4d" "glstub_glVertex4d"
external glVertex4dv: float array -> unit = "glstub_glVertex4dv" "glstub_glVertex4dv"
external glVertex4f: float -> float -> float -> float -> unit = "glstub_glVertex4f" "glstub_glVertex4f"

external glVertex4fv: float_array -> unit = "glstub_glVertex4fv" "glstub_glVertex4fv"
let glVertex4fv p0 =
let np0 = to_float_array p0 in
let r = glVertex4fv np0 in
r

external glVertex4hNV: int -> int -> int -> int -> unit = "glstub_glVertex4hNV" "glstub_glVertex4hNV"

external glVertex4hvNV: ushort_array -> unit = "glstub_glVertex4hvNV" "glstub_glVertex4hvNV"
let glVertex4hvNV p0 =
let np0 = to_ushort_array p0 in
let r = glVertex4hvNV np0 in
let _ = copy_ushort_array np0 p0 in
r

external glVertex4i: int -> int -> int -> int -> unit = "glstub_glVertex4i" "glstub_glVertex4i"

external glVertex4iv: word_array -> unit = "glstub_glVertex4iv" "glstub_glVertex4iv"
let glVertex4iv p0 =
let np0 = to_word_array p0 in
let r = glVertex4iv np0 in
r

external glVertex4s: int -> int -> int -> int -> unit = "glstub_glVertex4s" "glstub_glVertex4s"

external glVertex4sv: short_array -> unit = "glstub_glVertex4sv" "glstub_glVertex4sv"
let glVertex4sv p0 =
let np0 = to_short_array p0 in
let r = glVertex4sv np0 in
r

external glVertexArrayParameteriAPPLE: int -> int -> unit = "glstub_glVertexArrayParameteriAPPLE" "glstub_glVertexArrayParameteriAPPLE"
external glVertexArrayRangeAPPLE: int -> 'a -> unit = "glstub_glVertexArrayRangeAPPLE" "glstub_glVertexArrayRangeAPPLE"
external glVertexArrayRangeNV: int -> 'a -> unit = "glstub_glVertexArrayRangeNV" "glstub_glVertexArrayRangeNV"
external glVertexAttrib1d: int -> float -> unit = "glstub_glVertexAttrib1d" "glstub_glVertexAttrib1d"
external glVertexAttrib1dARB: int -> float -> unit = "glstub_glVertexAttrib1dARB" "glstub_glVertexAttrib1dARB"
external glVertexAttrib1dNV: int -> float -> unit = "glstub_glVertexAttrib1dNV" "glstub_glVertexAttrib1dNV"
external glVertexAttrib1dv: int -> float array -> unit = "glstub_glVertexAttrib1dv" "glstub_glVertexAttrib1dv"
external glVertexAttrib1dvARB: int -> float array -> unit = "glstub_glVertexAttrib1dvARB" "glstub_glVertexAttrib1dvARB"
external glVertexAttrib1dvNV: int -> float array -> unit = "glstub_glVertexAttrib1dvNV" "glstub_glVertexAttrib1dvNV"
external glVertexAttrib1f: int -> float -> unit = "glstub_glVertexAttrib1f" "glstub_glVertexAttrib1f"
external glVertexAttrib1fARB: int -> float -> unit = "glstub_glVertexAttrib1fARB" "glstub_glVertexAttrib1fARB"
external glVertexAttrib1fNV: int -> float -> unit = "glstub_glVertexAttrib1fNV" "glstub_glVertexAttrib1fNV"

external glVertexAttrib1fv: int -> float_array -> unit = "glstub_glVertexAttrib1fv" "glstub_glVertexAttrib1fv"
let glVertexAttrib1fv p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexAttrib1fv p0 np1 in
r


external glVertexAttrib1fvARB: int -> float_array -> unit = "glstub_glVertexAttrib1fvARB" "glstub_glVertexAttrib1fvARB"
let glVertexAttrib1fvARB p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexAttrib1fvARB p0 np1 in
let _ = copy_float_array np1 p1 in
r


external glVertexAttrib1fvNV: int -> float_array -> unit = "glstub_glVertexAttrib1fvNV" "glstub_glVertexAttrib1fvNV"
let glVertexAttrib1fvNV p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexAttrib1fvNV p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glVertexAttrib1hNV: int -> int -> unit = "glstub_glVertexAttrib1hNV" "glstub_glVertexAttrib1hNV"

external glVertexAttrib1hvNV: int -> ushort_array -> unit = "glstub_glVertexAttrib1hvNV" "glstub_glVertexAttrib1hvNV"
let glVertexAttrib1hvNV p0 p1 =
let np1 = to_ushort_array p1 in
let r = glVertexAttrib1hvNV p0 np1 in
let _ = copy_ushort_array np1 p1 in
r

external glVertexAttrib1s: int -> int -> unit = "glstub_glVertexAttrib1s" "glstub_glVertexAttrib1s"
external glVertexAttrib1sARB: int -> int -> unit = "glstub_glVertexAttrib1sARB" "glstub_glVertexAttrib1sARB"
external glVertexAttrib1sNV: int -> int -> unit = "glstub_glVertexAttrib1sNV" "glstub_glVertexAttrib1sNV"

external glVertexAttrib1sv: int -> short_array -> unit = "glstub_glVertexAttrib1sv" "glstub_glVertexAttrib1sv"
let glVertexAttrib1sv p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib1sv p0 np1 in
r


external glVertexAttrib1svARB: int -> short_array -> unit = "glstub_glVertexAttrib1svARB" "glstub_glVertexAttrib1svARB"
let glVertexAttrib1svARB p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib1svARB p0 np1 in
let _ = copy_short_array np1 p1 in
r


external glVertexAttrib1svNV: int -> short_array -> unit = "glstub_glVertexAttrib1svNV" "glstub_glVertexAttrib1svNV"
let glVertexAttrib1svNV p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib1svNV p0 np1 in
let _ = copy_short_array np1 p1 in
r

external glVertexAttrib2d: int -> float -> float -> unit = "glstub_glVertexAttrib2d" "glstub_glVertexAttrib2d"
external glVertexAttrib2dARB: int -> float -> float -> unit = "glstub_glVertexAttrib2dARB" "glstub_glVertexAttrib2dARB"
external glVertexAttrib2dNV: int -> float -> float -> unit = "glstub_glVertexAttrib2dNV" "glstub_glVertexAttrib2dNV"
external glVertexAttrib2dv: int -> float array -> unit = "glstub_glVertexAttrib2dv" "glstub_glVertexAttrib2dv"
external glVertexAttrib2dvARB: int -> float array -> unit = "glstub_glVertexAttrib2dvARB" "glstub_glVertexAttrib2dvARB"
external glVertexAttrib2dvNV: int -> float array -> unit = "glstub_glVertexAttrib2dvNV" "glstub_glVertexAttrib2dvNV"
external glVertexAttrib2f: int -> float -> float -> unit = "glstub_glVertexAttrib2f" "glstub_glVertexAttrib2f"
external glVertexAttrib2fARB: int -> float -> float -> unit = "glstub_glVertexAttrib2fARB" "glstub_glVertexAttrib2fARB"
external glVertexAttrib2fNV: int -> float -> float -> unit = "glstub_glVertexAttrib2fNV" "glstub_glVertexAttrib2fNV"

external glVertexAttrib2fv: int -> float_array -> unit = "glstub_glVertexAttrib2fv" "glstub_glVertexAttrib2fv"
let glVertexAttrib2fv p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexAttrib2fv p0 np1 in
r


external glVertexAttrib2fvARB: int -> float_array -> unit = "glstub_glVertexAttrib2fvARB" "glstub_glVertexAttrib2fvARB"
let glVertexAttrib2fvARB p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexAttrib2fvARB p0 np1 in
let _ = copy_float_array np1 p1 in
r


external glVertexAttrib2fvNV: int -> float_array -> unit = "glstub_glVertexAttrib2fvNV" "glstub_glVertexAttrib2fvNV"
let glVertexAttrib2fvNV p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexAttrib2fvNV p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glVertexAttrib2hNV: int -> int -> int -> unit = "glstub_glVertexAttrib2hNV" "glstub_glVertexAttrib2hNV"

external glVertexAttrib2hvNV: int -> ushort_array -> unit = "glstub_glVertexAttrib2hvNV" "glstub_glVertexAttrib2hvNV"
let glVertexAttrib2hvNV p0 p1 =
let np1 = to_ushort_array p1 in
let r = glVertexAttrib2hvNV p0 np1 in
let _ = copy_ushort_array np1 p1 in
r

external glVertexAttrib2s: int -> int -> int -> unit = "glstub_glVertexAttrib2s" "glstub_glVertexAttrib2s"
external glVertexAttrib2sARB: int -> int -> int -> unit = "glstub_glVertexAttrib2sARB" "glstub_glVertexAttrib2sARB"
external glVertexAttrib2sNV: int -> int -> int -> unit = "glstub_glVertexAttrib2sNV" "glstub_glVertexAttrib2sNV"

external glVertexAttrib2sv: int -> short_array -> unit = "glstub_glVertexAttrib2sv" "glstub_glVertexAttrib2sv"
let glVertexAttrib2sv p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib2sv p0 np1 in
r


external glVertexAttrib2svARB: int -> short_array -> unit = "glstub_glVertexAttrib2svARB" "glstub_glVertexAttrib2svARB"
let glVertexAttrib2svARB p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib2svARB p0 np1 in
let _ = copy_short_array np1 p1 in
r


external glVertexAttrib2svNV: int -> short_array -> unit = "glstub_glVertexAttrib2svNV" "glstub_glVertexAttrib2svNV"
let glVertexAttrib2svNV p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib2svNV p0 np1 in
let _ = copy_short_array np1 p1 in
r

external glVertexAttrib3d: int -> float -> float -> float -> unit = "glstub_glVertexAttrib3d" "glstub_glVertexAttrib3d"
external glVertexAttrib3dARB: int -> float -> float -> float -> unit = "glstub_glVertexAttrib3dARB" "glstub_glVertexAttrib3dARB"
external glVertexAttrib3dNV: int -> float -> float -> float -> unit = "glstub_glVertexAttrib3dNV" "glstub_glVertexAttrib3dNV"
external glVertexAttrib3dv: int -> float array -> unit = "glstub_glVertexAttrib3dv" "glstub_glVertexAttrib3dv"
external glVertexAttrib3dvARB: int -> float array -> unit = "glstub_glVertexAttrib3dvARB" "glstub_glVertexAttrib3dvARB"
external glVertexAttrib3dvNV: int -> float array -> unit = "glstub_glVertexAttrib3dvNV" "glstub_glVertexAttrib3dvNV"
external glVertexAttrib3f: int -> float -> float -> float -> unit = "glstub_glVertexAttrib3f" "glstub_glVertexAttrib3f"
external glVertexAttrib3fARB: int -> float -> float -> float -> unit = "glstub_glVertexAttrib3fARB" "glstub_glVertexAttrib3fARB"
external glVertexAttrib3fNV: int -> float -> float -> float -> unit = "glstub_glVertexAttrib3fNV" "glstub_glVertexAttrib3fNV"

external glVertexAttrib3fv: int -> float_array -> unit = "glstub_glVertexAttrib3fv" "glstub_glVertexAttrib3fv"
let glVertexAttrib3fv p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexAttrib3fv p0 np1 in
r


external glVertexAttrib3fvARB: int -> float_array -> unit = "glstub_glVertexAttrib3fvARB" "glstub_glVertexAttrib3fvARB"
let glVertexAttrib3fvARB p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexAttrib3fvARB p0 np1 in
let _ = copy_float_array np1 p1 in
r


external glVertexAttrib3fvNV: int -> float_array -> unit = "glstub_glVertexAttrib3fvNV" "glstub_glVertexAttrib3fvNV"
let glVertexAttrib3fvNV p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexAttrib3fvNV p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glVertexAttrib3hNV: int -> int -> int -> int -> unit = "glstub_glVertexAttrib3hNV" "glstub_glVertexAttrib3hNV"

external glVertexAttrib3hvNV: int -> ushort_array -> unit = "glstub_glVertexAttrib3hvNV" "glstub_glVertexAttrib3hvNV"
let glVertexAttrib3hvNV p0 p1 =
let np1 = to_ushort_array p1 in
let r = glVertexAttrib3hvNV p0 np1 in
let _ = copy_ushort_array np1 p1 in
r

external glVertexAttrib3s: int -> int -> int -> int -> unit = "glstub_glVertexAttrib3s" "glstub_glVertexAttrib3s"
external glVertexAttrib3sARB: int -> int -> int -> int -> unit = "glstub_glVertexAttrib3sARB" "glstub_glVertexAttrib3sARB"
external glVertexAttrib3sNV: int -> int -> int -> int -> unit = "glstub_glVertexAttrib3sNV" "glstub_glVertexAttrib3sNV"

external glVertexAttrib3sv: int -> short_array -> unit = "glstub_glVertexAttrib3sv" "glstub_glVertexAttrib3sv"
let glVertexAttrib3sv p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib3sv p0 np1 in
r


external glVertexAttrib3svARB: int -> short_array -> unit = "glstub_glVertexAttrib3svARB" "glstub_glVertexAttrib3svARB"
let glVertexAttrib3svARB p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib3svARB p0 np1 in
let _ = copy_short_array np1 p1 in
r


external glVertexAttrib3svNV: int -> short_array -> unit = "glstub_glVertexAttrib3svNV" "glstub_glVertexAttrib3svNV"
let glVertexAttrib3svNV p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib3svNV p0 np1 in
let _ = copy_short_array np1 p1 in
r


external glVertexAttrib4Nbv: int -> byte_array -> unit = "glstub_glVertexAttrib4Nbv" "glstub_glVertexAttrib4Nbv"
let glVertexAttrib4Nbv p0 p1 =
let np1 = to_byte_array p1 in
let r = glVertexAttrib4Nbv p0 np1 in
r


external glVertexAttrib4NbvARB: int -> byte_array -> unit = "glstub_glVertexAttrib4NbvARB" "glstub_glVertexAttrib4NbvARB"
let glVertexAttrib4NbvARB p0 p1 =
let np1 = to_byte_array p1 in
let r = glVertexAttrib4NbvARB p0 np1 in
let _ = copy_byte_array np1 p1 in
r


external glVertexAttrib4Niv: int -> word_array -> unit = "glstub_glVertexAttrib4Niv" "glstub_glVertexAttrib4Niv"
let glVertexAttrib4Niv p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttrib4Niv p0 np1 in
r


external glVertexAttrib4NivARB: int -> word_array -> unit = "glstub_glVertexAttrib4NivARB" "glstub_glVertexAttrib4NivARB"
let glVertexAttrib4NivARB p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttrib4NivARB p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glVertexAttrib4Nsv: int -> short_array -> unit = "glstub_glVertexAttrib4Nsv" "glstub_glVertexAttrib4Nsv"
let glVertexAttrib4Nsv p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib4Nsv p0 np1 in
r


external glVertexAttrib4NsvARB: int -> short_array -> unit = "glstub_glVertexAttrib4NsvARB" "glstub_glVertexAttrib4NsvARB"
let glVertexAttrib4NsvARB p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib4NsvARB p0 np1 in
let _ = copy_short_array np1 p1 in
r

external glVertexAttrib4Nub: int -> int -> int -> int -> int -> unit = "glstub_glVertexAttrib4Nub" "glstub_glVertexAttrib4Nub"
external glVertexAttrib4NubARB: int -> int -> int -> int -> int -> unit = "glstub_glVertexAttrib4NubARB" "glstub_glVertexAttrib4NubARB"

external glVertexAttrib4Nubv: int -> ubyte_array -> unit = "glstub_glVertexAttrib4Nubv" "glstub_glVertexAttrib4Nubv"
let glVertexAttrib4Nubv p0 p1 =
let np1 = to_ubyte_array p1 in
let r = glVertexAttrib4Nubv p0 np1 in
r


external glVertexAttrib4NubvARB: int -> ubyte_array -> unit = "glstub_glVertexAttrib4NubvARB" "glstub_glVertexAttrib4NubvARB"
let glVertexAttrib4NubvARB p0 p1 =
let np1 = to_ubyte_array p1 in
let r = glVertexAttrib4NubvARB p0 np1 in
let _ = copy_ubyte_array np1 p1 in
r


external glVertexAttrib4Nuiv: int -> word_array -> unit = "glstub_glVertexAttrib4Nuiv" "glstub_glVertexAttrib4Nuiv"
let glVertexAttrib4Nuiv p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttrib4Nuiv p0 np1 in
r


external glVertexAttrib4NuivARB: int -> word_array -> unit = "glstub_glVertexAttrib4NuivARB" "glstub_glVertexAttrib4NuivARB"
let glVertexAttrib4NuivARB p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttrib4NuivARB p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glVertexAttrib4Nusv: int -> ushort_array -> unit = "glstub_glVertexAttrib4Nusv" "glstub_glVertexAttrib4Nusv"
let glVertexAttrib4Nusv p0 p1 =
let np1 = to_ushort_array p1 in
let r = glVertexAttrib4Nusv p0 np1 in
r


external glVertexAttrib4NusvARB: int -> ushort_array -> unit = "glstub_glVertexAttrib4NusvARB" "glstub_glVertexAttrib4NusvARB"
let glVertexAttrib4NusvARB p0 p1 =
let np1 = to_ushort_array p1 in
let r = glVertexAttrib4NusvARB p0 np1 in
let _ = copy_ushort_array np1 p1 in
r


external glVertexAttrib4bv: int -> byte_array -> unit = "glstub_glVertexAttrib4bv" "glstub_glVertexAttrib4bv"
let glVertexAttrib4bv p0 p1 =
let np1 = to_byte_array p1 in
let r = glVertexAttrib4bv p0 np1 in
r


external glVertexAttrib4bvARB: int -> byte_array -> unit = "glstub_glVertexAttrib4bvARB" "glstub_glVertexAttrib4bvARB"
let glVertexAttrib4bvARB p0 p1 =
let np1 = to_byte_array p1 in
let r = glVertexAttrib4bvARB p0 np1 in
let _ = copy_byte_array np1 p1 in
r

external glVertexAttrib4d: int -> float -> float -> float -> float -> unit = "glstub_glVertexAttrib4d" "glstub_glVertexAttrib4d"
external glVertexAttrib4dARB: int -> float -> float -> float -> float -> unit = "glstub_glVertexAttrib4dARB" "glstub_glVertexAttrib4dARB"
external glVertexAttrib4dNV: int -> float -> float -> float -> float -> unit = "glstub_glVertexAttrib4dNV" "glstub_glVertexAttrib4dNV"
external glVertexAttrib4dv: int -> float array -> unit = "glstub_glVertexAttrib4dv" "glstub_glVertexAttrib4dv"
external glVertexAttrib4dvARB: int -> float array -> unit = "glstub_glVertexAttrib4dvARB" "glstub_glVertexAttrib4dvARB"
external glVertexAttrib4dvNV: int -> float array -> unit = "glstub_glVertexAttrib4dvNV" "glstub_glVertexAttrib4dvNV"
external glVertexAttrib4f: int -> float -> float -> float -> float -> unit = "glstub_glVertexAttrib4f" "glstub_glVertexAttrib4f"
external glVertexAttrib4fARB: int -> float -> float -> float -> float -> unit = "glstub_glVertexAttrib4fARB" "glstub_glVertexAttrib4fARB"
external glVertexAttrib4fNV: int -> float -> float -> float -> float -> unit = "glstub_glVertexAttrib4fNV" "glstub_glVertexAttrib4fNV"

external glVertexAttrib4fv: int -> float_array -> unit = "glstub_glVertexAttrib4fv" "glstub_glVertexAttrib4fv"
let glVertexAttrib4fv p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexAttrib4fv p0 np1 in
r


external glVertexAttrib4fvARB: int -> float_array -> unit = "glstub_glVertexAttrib4fvARB" "glstub_glVertexAttrib4fvARB"
let glVertexAttrib4fvARB p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexAttrib4fvARB p0 np1 in
let _ = copy_float_array np1 p1 in
r


external glVertexAttrib4fvNV: int -> float_array -> unit = "glstub_glVertexAttrib4fvNV" "glstub_glVertexAttrib4fvNV"
let glVertexAttrib4fvNV p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexAttrib4fvNV p0 np1 in
let _ = copy_float_array np1 p1 in
r

external glVertexAttrib4hNV: int -> int -> int -> int -> int -> unit = "glstub_glVertexAttrib4hNV" "glstub_glVertexAttrib4hNV"

external glVertexAttrib4hvNV: int -> ushort_array -> unit = "glstub_glVertexAttrib4hvNV" "glstub_glVertexAttrib4hvNV"
let glVertexAttrib4hvNV p0 p1 =
let np1 = to_ushort_array p1 in
let r = glVertexAttrib4hvNV p0 np1 in
let _ = copy_ushort_array np1 p1 in
r


external glVertexAttrib4iv: int -> word_array -> unit = "glstub_glVertexAttrib4iv" "glstub_glVertexAttrib4iv"
let glVertexAttrib4iv p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttrib4iv p0 np1 in
r


external glVertexAttrib4ivARB: int -> word_array -> unit = "glstub_glVertexAttrib4ivARB" "glstub_glVertexAttrib4ivARB"
let glVertexAttrib4ivARB p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttrib4ivARB p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glVertexAttrib4s: int -> int -> int -> int -> int -> unit = "glstub_glVertexAttrib4s" "glstub_glVertexAttrib4s"
external glVertexAttrib4sARB: int -> int -> int -> int -> int -> unit = "glstub_glVertexAttrib4sARB" "glstub_glVertexAttrib4sARB"
external glVertexAttrib4sNV: int -> int -> int -> int -> int -> unit = "glstub_glVertexAttrib4sNV" "glstub_glVertexAttrib4sNV"

external glVertexAttrib4sv: int -> short_array -> unit = "glstub_glVertexAttrib4sv" "glstub_glVertexAttrib4sv"
let glVertexAttrib4sv p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib4sv p0 np1 in
r


external glVertexAttrib4svARB: int -> short_array -> unit = "glstub_glVertexAttrib4svARB" "glstub_glVertexAttrib4svARB"
let glVertexAttrib4svARB p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib4svARB p0 np1 in
let _ = copy_short_array np1 p1 in
r


external glVertexAttrib4svNV: int -> short_array -> unit = "glstub_glVertexAttrib4svNV" "glstub_glVertexAttrib4svNV"
let glVertexAttrib4svNV p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttrib4svNV p0 np1 in
let _ = copy_short_array np1 p1 in
r

external glVertexAttrib4ubNV: int -> int -> int -> int -> int -> unit = "glstub_glVertexAttrib4ubNV" "glstub_glVertexAttrib4ubNV"

external glVertexAttrib4ubv: int -> ubyte_array -> unit = "glstub_glVertexAttrib4ubv" "glstub_glVertexAttrib4ubv"
let glVertexAttrib4ubv p0 p1 =
let np1 = to_ubyte_array p1 in
let r = glVertexAttrib4ubv p0 np1 in
r


external glVertexAttrib4ubvARB: int -> ubyte_array -> unit = "glstub_glVertexAttrib4ubvARB" "glstub_glVertexAttrib4ubvARB"
let glVertexAttrib4ubvARB p0 p1 =
let np1 = to_ubyte_array p1 in
let r = glVertexAttrib4ubvARB p0 np1 in
let _ = copy_ubyte_array np1 p1 in
r


external glVertexAttrib4ubvNV: int -> ubyte_array -> unit = "glstub_glVertexAttrib4ubvNV" "glstub_glVertexAttrib4ubvNV"
let glVertexAttrib4ubvNV p0 p1 =
let np1 = to_ubyte_array p1 in
let r = glVertexAttrib4ubvNV p0 np1 in
let _ = copy_ubyte_array np1 p1 in
r


external glVertexAttrib4uiv: int -> word_array -> unit = "glstub_glVertexAttrib4uiv" "glstub_glVertexAttrib4uiv"
let glVertexAttrib4uiv p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttrib4uiv p0 np1 in
r


external glVertexAttrib4uivARB: int -> word_array -> unit = "glstub_glVertexAttrib4uivARB" "glstub_glVertexAttrib4uivARB"
let glVertexAttrib4uivARB p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttrib4uivARB p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glVertexAttrib4usv: int -> ushort_array -> unit = "glstub_glVertexAttrib4usv" "glstub_glVertexAttrib4usv"
let glVertexAttrib4usv p0 p1 =
let np1 = to_ushort_array p1 in
let r = glVertexAttrib4usv p0 np1 in
r


external glVertexAttrib4usvARB: int -> ushort_array -> unit = "glstub_glVertexAttrib4usvARB" "glstub_glVertexAttrib4usvARB"
let glVertexAttrib4usvARB p0 p1 =
let np1 = to_ushort_array p1 in
let r = glVertexAttrib4usvARB p0 np1 in
let _ = copy_ushort_array np1 p1 in
r

external glVertexAttribArrayObjectATI: int -> int -> int -> bool -> int -> int -> int -> unit = "glstub_glVertexAttribArrayObjectATI_byte" "glstub_glVertexAttribArrayObjectATI"
external glVertexAttribI1iEXT: int -> int -> unit = "glstub_glVertexAttribI1iEXT" "glstub_glVertexAttribI1iEXT"

external glVertexAttribI1ivEXT: int -> word_array -> unit = "glstub_glVertexAttribI1ivEXT" "glstub_glVertexAttribI1ivEXT"
let glVertexAttribI1ivEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttribI1ivEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glVertexAttribI1uiEXT: int -> int -> unit = "glstub_glVertexAttribI1uiEXT" "glstub_glVertexAttribI1uiEXT"

external glVertexAttribI1uivEXT: int -> word_array -> unit = "glstub_glVertexAttribI1uivEXT" "glstub_glVertexAttribI1uivEXT"
let glVertexAttribI1uivEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttribI1uivEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glVertexAttribI2iEXT: int -> int -> int -> unit = "glstub_glVertexAttribI2iEXT" "glstub_glVertexAttribI2iEXT"

external glVertexAttribI2ivEXT: int -> word_array -> unit = "glstub_glVertexAttribI2ivEXT" "glstub_glVertexAttribI2ivEXT"
let glVertexAttribI2ivEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttribI2ivEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glVertexAttribI2uiEXT: int -> int -> int -> unit = "glstub_glVertexAttribI2uiEXT" "glstub_glVertexAttribI2uiEXT"

external glVertexAttribI2uivEXT: int -> word_array -> unit = "glstub_glVertexAttribI2uivEXT" "glstub_glVertexAttribI2uivEXT"
let glVertexAttribI2uivEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttribI2uivEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glVertexAttribI3iEXT: int -> int -> int -> int -> unit = "glstub_glVertexAttribI3iEXT" "glstub_glVertexAttribI3iEXT"

external glVertexAttribI3ivEXT: int -> word_array -> unit = "glstub_glVertexAttribI3ivEXT" "glstub_glVertexAttribI3ivEXT"
let glVertexAttribI3ivEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttribI3ivEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r

external glVertexAttribI3uiEXT: int -> int -> int -> int -> unit = "glstub_glVertexAttribI3uiEXT" "glstub_glVertexAttribI3uiEXT"

external glVertexAttribI3uivEXT: int -> word_array -> unit = "glstub_glVertexAttribI3uivEXT" "glstub_glVertexAttribI3uivEXT"
let glVertexAttribI3uivEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttribI3uivEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glVertexAttribI4bvEXT: int -> byte_array -> unit = "glstub_glVertexAttribI4bvEXT" "glstub_glVertexAttribI4bvEXT"
let glVertexAttribI4bvEXT p0 p1 =
let np1 = to_byte_array p1 in
let r = glVertexAttribI4bvEXT p0 np1 in
let _ = copy_byte_array np1 p1 in
r

external glVertexAttribI4iEXT: int -> int -> int -> int -> int -> unit = "glstub_glVertexAttribI4iEXT" "glstub_glVertexAttribI4iEXT"

external glVertexAttribI4ivEXT: int -> word_array -> unit = "glstub_glVertexAttribI4ivEXT" "glstub_glVertexAttribI4ivEXT"
let glVertexAttribI4ivEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttribI4ivEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glVertexAttribI4svEXT: int -> short_array -> unit = "glstub_glVertexAttribI4svEXT" "glstub_glVertexAttribI4svEXT"
let glVertexAttribI4svEXT p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexAttribI4svEXT p0 np1 in
let _ = copy_short_array np1 p1 in
r


external glVertexAttribI4ubvEXT: int -> ubyte_array -> unit = "glstub_glVertexAttribI4ubvEXT" "glstub_glVertexAttribI4ubvEXT"
let glVertexAttribI4ubvEXT p0 p1 =
let np1 = to_ubyte_array p1 in
let r = glVertexAttribI4ubvEXT p0 np1 in
let _ = copy_ubyte_array np1 p1 in
r

external glVertexAttribI4uiEXT: int -> int -> int -> int -> int -> unit = "glstub_glVertexAttribI4uiEXT" "glstub_glVertexAttribI4uiEXT"

external glVertexAttribI4uivEXT: int -> word_array -> unit = "glstub_glVertexAttribI4uivEXT" "glstub_glVertexAttribI4uivEXT"
let glVertexAttribI4uivEXT p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexAttribI4uivEXT p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glVertexAttribI4usvEXT: int -> ushort_array -> unit = "glstub_glVertexAttribI4usvEXT" "glstub_glVertexAttribI4usvEXT"
let glVertexAttribI4usvEXT p0 p1 =
let np1 = to_ushort_array p1 in
let r = glVertexAttribI4usvEXT p0 np1 in
let _ = copy_ushort_array np1 p1 in
r

external glVertexAttribIPointerEXT: int -> int -> int -> int -> 'a -> unit = "glstub_glVertexAttribIPointerEXT" "glstub_glVertexAttribIPointerEXT"
external glVertexAttribPointer: int -> int -> int -> bool -> int -> 'a -> unit = "glstub_glVertexAttribPointer_byte" "glstub_glVertexAttribPointer"
external glVertexAttribPointerARB: int -> int -> int -> bool -> int -> 'a -> unit = "glstub_glVertexAttribPointerARB_byte" "glstub_glVertexAttribPointerARB"
external glVertexAttribPointerNV: int -> int -> int -> int -> 'a -> unit = "glstub_glVertexAttribPointerNV" "glstub_glVertexAttribPointerNV"
external glVertexAttribs1dvNV: int -> int -> float array -> unit = "glstub_glVertexAttribs1dvNV" "glstub_glVertexAttribs1dvNV"

external glVertexAttribs1fvNV: int -> int -> float_array -> unit = "glstub_glVertexAttribs1fvNV" "glstub_glVertexAttribs1fvNV"
let glVertexAttribs1fvNV p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glVertexAttribs1fvNV p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glVertexAttribs1hvNV: int -> int -> ushort_array -> unit = "glstub_glVertexAttribs1hvNV" "glstub_glVertexAttribs1hvNV"
let glVertexAttribs1hvNV p0 p1 p2 =
let np2 = to_ushort_array p2 in
let r = glVertexAttribs1hvNV p0 p1 np2 in
let _ = copy_ushort_array np2 p2 in
r


external glVertexAttribs1svNV: int -> int -> short_array -> unit = "glstub_glVertexAttribs1svNV" "glstub_glVertexAttribs1svNV"
let glVertexAttribs1svNV p0 p1 p2 =
let np2 = to_short_array p2 in
let r = glVertexAttribs1svNV p0 p1 np2 in
let _ = copy_short_array np2 p2 in
r

external glVertexAttribs2dvNV: int -> int -> float array -> unit = "glstub_glVertexAttribs2dvNV" "glstub_glVertexAttribs2dvNV"

external glVertexAttribs2fvNV: int -> int -> float_array -> unit = "glstub_glVertexAttribs2fvNV" "glstub_glVertexAttribs2fvNV"
let glVertexAttribs2fvNV p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glVertexAttribs2fvNV p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glVertexAttribs2hvNV: int -> int -> ushort_array -> unit = "glstub_glVertexAttribs2hvNV" "glstub_glVertexAttribs2hvNV"
let glVertexAttribs2hvNV p0 p1 p2 =
let np2 = to_ushort_array p2 in
let r = glVertexAttribs2hvNV p0 p1 np2 in
let _ = copy_ushort_array np2 p2 in
r


external glVertexAttribs2svNV: int -> int -> short_array -> unit = "glstub_glVertexAttribs2svNV" "glstub_glVertexAttribs2svNV"
let glVertexAttribs2svNV p0 p1 p2 =
let np2 = to_short_array p2 in
let r = glVertexAttribs2svNV p0 p1 np2 in
let _ = copy_short_array np2 p2 in
r

external glVertexAttribs3dvNV: int -> int -> float array -> unit = "glstub_glVertexAttribs3dvNV" "glstub_glVertexAttribs3dvNV"

external glVertexAttribs3fvNV: int -> int -> float_array -> unit = "glstub_glVertexAttribs3fvNV" "glstub_glVertexAttribs3fvNV"
let glVertexAttribs3fvNV p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glVertexAttribs3fvNV p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glVertexAttribs3hvNV: int -> int -> ushort_array -> unit = "glstub_glVertexAttribs3hvNV" "glstub_glVertexAttribs3hvNV"
let glVertexAttribs3hvNV p0 p1 p2 =
let np2 = to_ushort_array p2 in
let r = glVertexAttribs3hvNV p0 p1 np2 in
let _ = copy_ushort_array np2 p2 in
r


external glVertexAttribs3svNV: int -> int -> short_array -> unit = "glstub_glVertexAttribs3svNV" "glstub_glVertexAttribs3svNV"
let glVertexAttribs3svNV p0 p1 p2 =
let np2 = to_short_array p2 in
let r = glVertexAttribs3svNV p0 p1 np2 in
let _ = copy_short_array np2 p2 in
r

external glVertexAttribs4dvNV: int -> int -> float array -> unit = "glstub_glVertexAttribs4dvNV" "glstub_glVertexAttribs4dvNV"

external glVertexAttribs4fvNV: int -> int -> float_array -> unit = "glstub_glVertexAttribs4fvNV" "glstub_glVertexAttribs4fvNV"
let glVertexAttribs4fvNV p0 p1 p2 =
let np2 = to_float_array p2 in
let r = glVertexAttribs4fvNV p0 p1 np2 in
let _ = copy_float_array np2 p2 in
r


external glVertexAttribs4hvNV: int -> int -> ushort_array -> unit = "glstub_glVertexAttribs4hvNV" "glstub_glVertexAttribs4hvNV"
let glVertexAttribs4hvNV p0 p1 p2 =
let np2 = to_ushort_array p2 in
let r = glVertexAttribs4hvNV p0 p1 np2 in
let _ = copy_ushort_array np2 p2 in
r


external glVertexAttribs4svNV: int -> int -> short_array -> unit = "glstub_glVertexAttribs4svNV" "glstub_glVertexAttribs4svNV"
let glVertexAttribs4svNV p0 p1 p2 =
let np2 = to_short_array p2 in
let r = glVertexAttribs4svNV p0 p1 np2 in
let _ = copy_short_array np2 p2 in
r


external glVertexAttribs4ubvNV: int -> int -> ubyte_array -> unit = "glstub_glVertexAttribs4ubvNV" "glstub_glVertexAttribs4ubvNV"
let glVertexAttribs4ubvNV p0 p1 p2 =
let np2 = to_ubyte_array p2 in
let r = glVertexAttribs4ubvNV p0 p1 np2 in
let _ = copy_ubyte_array np2 p2 in
r

external glVertexBlendARB: int -> unit = "glstub_glVertexBlendARB" "glstub_glVertexBlendARB"
external glVertexBlendEnvfATI: int -> float -> unit = "glstub_glVertexBlendEnvfATI" "glstub_glVertexBlendEnvfATI"
external glVertexBlendEnviATI: int -> int -> unit = "glstub_glVertexBlendEnviATI" "glstub_glVertexBlendEnviATI"
external glVertexPointer: int -> int -> int -> 'a -> unit = "glstub_glVertexPointer" "glstub_glVertexPointer"
external glVertexPointerEXT: int -> int -> int -> int -> 'a -> unit = "glstub_glVertexPointerEXT" "glstub_glVertexPointerEXT"
external glVertexPointerListIBM: int -> int -> int -> 'a -> int -> unit = "glstub_glVertexPointerListIBM" "glstub_glVertexPointerListIBM"
external glVertexPointervINTEL: int -> int -> 'a -> unit = "glstub_glVertexPointervINTEL" "glstub_glVertexPointervINTEL"
external glVertexStream2dATI: int -> float -> float -> unit = "glstub_glVertexStream2dATI" "glstub_glVertexStream2dATI"
external glVertexStream2dvATI: int -> float array -> unit = "glstub_glVertexStream2dvATI" "glstub_glVertexStream2dvATI"
external glVertexStream2fATI: int -> float -> float -> unit = "glstub_glVertexStream2fATI" "glstub_glVertexStream2fATI"

external glVertexStream2fvATI: int -> float_array -> unit = "glstub_glVertexStream2fvATI" "glstub_glVertexStream2fvATI"
let glVertexStream2fvATI p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexStream2fvATI p0 np1 in
r

external glVertexStream2iATI: int -> int -> int -> unit = "glstub_glVertexStream2iATI" "glstub_glVertexStream2iATI"

external glVertexStream2ivATI: int -> word_array -> unit = "glstub_glVertexStream2ivATI" "glstub_glVertexStream2ivATI"
let glVertexStream2ivATI p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexStream2ivATI p0 np1 in
r

external glVertexStream2sATI: int -> int -> int -> unit = "glstub_glVertexStream2sATI" "glstub_glVertexStream2sATI"

external glVertexStream2svATI: int -> short_array -> unit = "glstub_glVertexStream2svATI" "glstub_glVertexStream2svATI"
let glVertexStream2svATI p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexStream2svATI p0 np1 in
r

external glVertexStream3dATI: int -> float -> float -> float -> unit = "glstub_glVertexStream3dATI" "glstub_glVertexStream3dATI"
external glVertexStream3dvATI: int -> float array -> unit = "glstub_glVertexStream3dvATI" "glstub_glVertexStream3dvATI"
external glVertexStream3fATI: int -> float -> float -> float -> unit = "glstub_glVertexStream3fATI" "glstub_glVertexStream3fATI"

external glVertexStream3fvATI: int -> float_array -> unit = "glstub_glVertexStream3fvATI" "glstub_glVertexStream3fvATI"
let glVertexStream3fvATI p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexStream3fvATI p0 np1 in
r

external glVertexStream3iATI: int -> int -> int -> int -> unit = "glstub_glVertexStream3iATI" "glstub_glVertexStream3iATI"

external glVertexStream3ivATI: int -> word_array -> unit = "glstub_glVertexStream3ivATI" "glstub_glVertexStream3ivATI"
let glVertexStream3ivATI p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexStream3ivATI p0 np1 in
r

external glVertexStream3sATI: int -> int -> int -> int -> unit = "glstub_glVertexStream3sATI" "glstub_glVertexStream3sATI"

external glVertexStream3svATI: int -> short_array -> unit = "glstub_glVertexStream3svATI" "glstub_glVertexStream3svATI"
let glVertexStream3svATI p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexStream3svATI p0 np1 in
r

external glVertexStream4dATI: int -> float -> float -> float -> float -> unit = "glstub_glVertexStream4dATI" "glstub_glVertexStream4dATI"
external glVertexStream4dvATI: int -> float array -> unit = "glstub_glVertexStream4dvATI" "glstub_glVertexStream4dvATI"
external glVertexStream4fATI: int -> float -> float -> float -> float -> unit = "glstub_glVertexStream4fATI" "glstub_glVertexStream4fATI"

external glVertexStream4fvATI: int -> float_array -> unit = "glstub_glVertexStream4fvATI" "glstub_glVertexStream4fvATI"
let glVertexStream4fvATI p0 p1 =
let np1 = to_float_array p1 in
let r = glVertexStream4fvATI p0 np1 in
r

external glVertexStream4iATI: int -> int -> int -> int -> int -> unit = "glstub_glVertexStream4iATI" "glstub_glVertexStream4iATI"

external glVertexStream4ivATI: int -> word_array -> unit = "glstub_glVertexStream4ivATI" "glstub_glVertexStream4ivATI"
let glVertexStream4ivATI p0 p1 =
let np1 = to_word_array p1 in
let r = glVertexStream4ivATI p0 np1 in
r

external glVertexStream4sATI: int -> int -> int -> int -> int -> unit = "glstub_glVertexStream4sATI" "glstub_glVertexStream4sATI"

external glVertexStream4svATI: int -> short_array -> unit = "glstub_glVertexStream4svATI" "glstub_glVertexStream4svATI"
let glVertexStream4svATI p0 p1 =
let np1 = to_short_array p1 in
let r = glVertexStream4svATI p0 np1 in
r

external glVertexWeightPointerEXT: int -> int -> int -> 'a -> unit = "glstub_glVertexWeightPointerEXT" "glstub_glVertexWeightPointerEXT"
external glVertexWeightfEXT: float -> unit = "glstub_glVertexWeightfEXT" "glstub_glVertexWeightfEXT"

external glVertexWeightfvEXT: float_array -> unit = "glstub_glVertexWeightfvEXT" "glstub_glVertexWeightfvEXT"
let glVertexWeightfvEXT p0 =
let np0 = to_float_array p0 in
let r = glVertexWeightfvEXT np0 in
let _ = copy_float_array np0 p0 in
r

external glVertexWeighthNV: int -> unit = "glstub_glVertexWeighthNV" "glstub_glVertexWeighthNV"

external glVertexWeighthvNV: ushort_array -> unit = "glstub_glVertexWeighthvNV" "glstub_glVertexWeighthvNV"
let glVertexWeighthvNV p0 =
let np0 = to_ushort_array p0 in
let r = glVertexWeighthvNV np0 in
let _ = copy_ushort_array np0 p0 in
r

external glViewport: int -> int -> int -> int -> unit = "glstub_glViewport" "glstub_glViewport"
external glWeightPointerARB: int -> int -> int -> 'a -> unit = "glstub_glWeightPointerARB" "glstub_glWeightPointerARB"

external glWeightbvARB: int -> byte_array -> unit = "glstub_glWeightbvARB" "glstub_glWeightbvARB"
let glWeightbvARB p0 p1 =
let np1 = to_byte_array p1 in
let r = glWeightbvARB p0 np1 in
let _ = copy_byte_array np1 p1 in
r

external glWeightdvARB: int -> float array -> unit = "glstub_glWeightdvARB" "glstub_glWeightdvARB"

external glWeightfvARB: int -> float_array -> unit = "glstub_glWeightfvARB" "glstub_glWeightfvARB"
let glWeightfvARB p0 p1 =
let np1 = to_float_array p1 in
let r = glWeightfvARB p0 np1 in
let _ = copy_float_array np1 p1 in
r


external glWeightivARB: int -> word_array -> unit = "glstub_glWeightivARB" "glstub_glWeightivARB"
let glWeightivARB p0 p1 =
let np1 = to_word_array p1 in
let r = glWeightivARB p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glWeightsvARB: int -> short_array -> unit = "glstub_glWeightsvARB" "glstub_glWeightsvARB"
let glWeightsvARB p0 p1 =
let np1 = to_short_array p1 in
let r = glWeightsvARB p0 np1 in
let _ = copy_short_array np1 p1 in
r


external glWeightubvARB: int -> ubyte_array -> unit = "glstub_glWeightubvARB" "glstub_glWeightubvARB"
let glWeightubvARB p0 p1 =
let np1 = to_ubyte_array p1 in
let r = glWeightubvARB p0 np1 in
let _ = copy_ubyte_array np1 p1 in
r


external glWeightuivARB: int -> word_array -> unit = "glstub_glWeightuivARB" "glstub_glWeightuivARB"
let glWeightuivARB p0 p1 =
let np1 = to_word_array p1 in
let r = glWeightuivARB p0 np1 in
let _ = copy_word_array np1 p1 in
r


external glWeightusvARB: int -> ushort_array -> unit = "glstub_glWeightusvARB" "glstub_glWeightusvARB"
let glWeightusvARB p0 p1 =
let np1 = to_ushort_array p1 in
let r = glWeightusvARB p0 np1 in
let _ = copy_ushort_array np1 p1 in
r

external glWindowPos2d: float -> float -> unit = "glstub_glWindowPos2d" "glstub_glWindowPos2d"
external glWindowPos2dARB: float -> float -> unit = "glstub_glWindowPos2dARB" "glstub_glWindowPos2dARB"
external glWindowPos2dMESA: float -> float -> unit = "glstub_glWindowPos2dMESA" "glstub_glWindowPos2dMESA"
external glWindowPos2dv: float array -> unit = "glstub_glWindowPos2dv" "glstub_glWindowPos2dv"
external glWindowPos2dvARB: float array -> unit = "glstub_glWindowPos2dvARB" "glstub_glWindowPos2dvARB"
external glWindowPos2dvMESA: float array -> unit = "glstub_glWindowPos2dvMESA" "glstub_glWindowPos2dvMESA"
external glWindowPos2f: float -> float -> unit = "glstub_glWindowPos2f" "glstub_glWindowPos2f"
external glWindowPos2fARB: float -> float -> unit = "glstub_glWindowPos2fARB" "glstub_glWindowPos2fARB"
external glWindowPos2fMESA: float -> float -> unit = "glstub_glWindowPos2fMESA" "glstub_glWindowPos2fMESA"

external glWindowPos2fv: float_array -> unit = "glstub_glWindowPos2fv" "glstub_glWindowPos2fv"
let glWindowPos2fv p0 =
let np0 = to_float_array p0 in
let r = glWindowPos2fv np0 in
r


external glWindowPos2fvARB: float_array -> unit = "glstub_glWindowPos2fvARB" "glstub_glWindowPos2fvARB"
let glWindowPos2fvARB p0 =
let np0 = to_float_array p0 in
let r = glWindowPos2fvARB np0 in
let _ = copy_float_array np0 p0 in
r


external glWindowPos2fvMESA: float_array -> unit = "glstub_glWindowPos2fvMESA" "glstub_glWindowPos2fvMESA"
let glWindowPos2fvMESA p0 =
let np0 = to_float_array p0 in
let r = glWindowPos2fvMESA np0 in
let _ = copy_float_array np0 p0 in
r

external glWindowPos2i: int -> int -> unit = "glstub_glWindowPos2i" "glstub_glWindowPos2i"
external glWindowPos2iARB: int -> int -> unit = "glstub_glWindowPos2iARB" "glstub_glWindowPos2iARB"
external glWindowPos2iMESA: int -> int -> unit = "glstub_glWindowPos2iMESA" "glstub_glWindowPos2iMESA"

external glWindowPos2iv: word_array -> unit = "glstub_glWindowPos2iv" "glstub_glWindowPos2iv"
let glWindowPos2iv p0 =
let np0 = to_word_array p0 in
let r = glWindowPos2iv np0 in
r


external glWindowPos2ivARB: word_array -> unit = "glstub_glWindowPos2ivARB" "glstub_glWindowPos2ivARB"
let glWindowPos2ivARB p0 =
let np0 = to_word_array p0 in
let r = glWindowPos2ivARB np0 in
let _ = copy_word_array np0 p0 in
r


external glWindowPos2ivMESA: word_array -> unit = "glstub_glWindowPos2ivMESA" "glstub_glWindowPos2ivMESA"
let glWindowPos2ivMESA p0 =
let np0 = to_word_array p0 in
let r = glWindowPos2ivMESA np0 in
let _ = copy_word_array np0 p0 in
r

external glWindowPos2s: int -> int -> unit = "glstub_glWindowPos2s" "glstub_glWindowPos2s"
external glWindowPos2sARB: int -> int -> unit = "glstub_glWindowPos2sARB" "glstub_glWindowPos2sARB"
external glWindowPos2sMESA: int -> int -> unit = "glstub_glWindowPos2sMESA" "glstub_glWindowPos2sMESA"

external glWindowPos2sv: short_array -> unit = "glstub_glWindowPos2sv" "glstub_glWindowPos2sv"
let glWindowPos2sv p0 =
let np0 = to_short_array p0 in
let r = glWindowPos2sv np0 in
r


external glWindowPos2svARB: short_array -> unit = "glstub_glWindowPos2svARB" "glstub_glWindowPos2svARB"
let glWindowPos2svARB p0 =
let np0 = to_short_array p0 in
let r = glWindowPos2svARB np0 in
let _ = copy_short_array np0 p0 in
r


external glWindowPos2svMESA: short_array -> unit = "glstub_glWindowPos2svMESA" "glstub_glWindowPos2svMESA"
let glWindowPos2svMESA p0 =
let np0 = to_short_array p0 in
let r = glWindowPos2svMESA np0 in
let _ = copy_short_array np0 p0 in
r

external glWindowPos3d: float -> float -> float -> unit = "glstub_glWindowPos3d" "glstub_glWindowPos3d"
external glWindowPos3dARB: float -> float -> float -> unit = "glstub_glWindowPos3dARB" "glstub_glWindowPos3dARB"
external glWindowPos3dMESA: float -> float -> float -> unit = "glstub_glWindowPos3dMESA" "glstub_glWindowPos3dMESA"
external glWindowPos3dv: float array -> unit = "glstub_glWindowPos3dv" "glstub_glWindowPos3dv"
external glWindowPos3dvARB: float array -> unit = "glstub_glWindowPos3dvARB" "glstub_glWindowPos3dvARB"
external glWindowPos3dvMESA: float array -> unit = "glstub_glWindowPos3dvMESA" "glstub_glWindowPos3dvMESA"
external glWindowPos3f: float -> float -> float -> unit = "glstub_glWindowPos3f" "glstub_glWindowPos3f"
external glWindowPos3fARB: float -> float -> float -> unit = "glstub_glWindowPos3fARB" "glstub_glWindowPos3fARB"
external glWindowPos3fMESA: float -> float -> float -> unit = "glstub_glWindowPos3fMESA" "glstub_glWindowPos3fMESA"

external glWindowPos3fv: float_array -> unit = "glstub_glWindowPos3fv" "glstub_glWindowPos3fv"
let glWindowPos3fv p0 =
let np0 = to_float_array p0 in
let r = glWindowPos3fv np0 in
r


external glWindowPos3fvARB: float_array -> unit = "glstub_glWindowPos3fvARB" "glstub_glWindowPos3fvARB"
let glWindowPos3fvARB p0 =
let np0 = to_float_array p0 in
let r = glWindowPos3fvARB np0 in
let _ = copy_float_array np0 p0 in
r


external glWindowPos3fvMESA: float_array -> unit = "glstub_glWindowPos3fvMESA" "glstub_glWindowPos3fvMESA"
let glWindowPos3fvMESA p0 =
let np0 = to_float_array p0 in
let r = glWindowPos3fvMESA np0 in
let _ = copy_float_array np0 p0 in
r

external glWindowPos3i: int -> int -> int -> unit = "glstub_glWindowPos3i" "glstub_glWindowPos3i"
external glWindowPos3iARB: int -> int -> int -> unit = "glstub_glWindowPos3iARB" "glstub_glWindowPos3iARB"
external glWindowPos3iMESA: int -> int -> int -> unit = "glstub_glWindowPos3iMESA" "glstub_glWindowPos3iMESA"

external glWindowPos3iv: word_array -> unit = "glstub_glWindowPos3iv" "glstub_glWindowPos3iv"
let glWindowPos3iv p0 =
let np0 = to_word_array p0 in
let r = glWindowPos3iv np0 in
r


external glWindowPos3ivARB: word_array -> unit = "glstub_glWindowPos3ivARB" "glstub_glWindowPos3ivARB"
let glWindowPos3ivARB p0 =
let np0 = to_word_array p0 in
let r = glWindowPos3ivARB np0 in
let _ = copy_word_array np0 p0 in
r


external glWindowPos3ivMESA: word_array -> unit = "glstub_glWindowPos3ivMESA" "glstub_glWindowPos3ivMESA"
let glWindowPos3ivMESA p0 =
let np0 = to_word_array p0 in
let r = glWindowPos3ivMESA np0 in
let _ = copy_word_array np0 p0 in
r

external glWindowPos3s: int -> int -> int -> unit = "glstub_glWindowPos3s" "glstub_glWindowPos3s"
external glWindowPos3sARB: int -> int -> int -> unit = "glstub_glWindowPos3sARB" "glstub_glWindowPos3sARB"
external glWindowPos3sMESA: int -> int -> int -> unit = "glstub_glWindowPos3sMESA" "glstub_glWindowPos3sMESA"

external glWindowPos3sv: short_array -> unit = "glstub_glWindowPos3sv" "glstub_glWindowPos3sv"
let glWindowPos3sv p0 =
let np0 = to_short_array p0 in
let r = glWindowPos3sv np0 in
r


external glWindowPos3svARB: short_array -> unit = "glstub_glWindowPos3svARB" "glstub_glWindowPos3svARB"
let glWindowPos3svARB p0 =
let np0 = to_short_array p0 in
let r = glWindowPos3svARB np0 in
let _ = copy_short_array np0 p0 in
r


external glWindowPos3svMESA: short_array -> unit = "glstub_glWindowPos3svMESA" "glstub_glWindowPos3svMESA"
let glWindowPos3svMESA p0 =
let np0 = to_short_array p0 in
let r = glWindowPos3svMESA np0 in
let _ = copy_short_array np0 p0 in
r

external glWindowPos4dMESA: float -> float -> float -> float -> unit = "glstub_glWindowPos4dMESA" "glstub_glWindowPos4dMESA"
external glWindowPos4dvMESA: float array -> unit = "glstub_glWindowPos4dvMESA" "glstub_glWindowPos4dvMESA"
external glWindowPos4fMESA: float -> float -> float -> float -> unit = "glstub_glWindowPos4fMESA" "glstub_glWindowPos4fMESA"

external glWindowPos4fvMESA: float_array -> unit = "glstub_glWindowPos4fvMESA" "glstub_glWindowPos4fvMESA"
let glWindowPos4fvMESA p0 =
let np0 = to_float_array p0 in
let r = glWindowPos4fvMESA np0 in
let _ = copy_float_array np0 p0 in
r

external glWindowPos4iMESA: int -> int -> int -> int -> unit = "glstub_glWindowPos4iMESA" "glstub_glWindowPos4iMESA"

external glWindowPos4ivMESA: word_array -> unit = "glstub_glWindowPos4ivMESA" "glstub_glWindowPos4ivMESA"
let glWindowPos4ivMESA p0 =
let np0 = to_word_array p0 in
let r = glWindowPos4ivMESA np0 in
let _ = copy_word_array np0 p0 in
r

external glWindowPos4sMESA: int -> int -> int -> int -> unit = "glstub_glWindowPos4sMESA" "glstub_glWindowPos4sMESA"

external glWindowPos4svMESA: short_array -> unit = "glstub_glWindowPos4svMESA" "glstub_glWindowPos4svMESA"
let glWindowPos4svMESA p0 =
let np0 = to_short_array p0 in
let r = glWindowPos4svMESA np0 in
let _ = copy_short_array np0 p0 in
r

external glWriteMaskEXT: int -> int -> int -> int -> int -> int -> unit = "glstub_glWriteMaskEXT_byte" "glstub_glWriteMaskEXT"
