(**
 GLCaml - Objective Caml interface for OpenGL 1.1, 1.2, 1.3, 1.4, 1.5, 2.0 and 2.1
 plus ARB and vendor-specific extensions 
 *) 

(* Copyright (C) 2007, 2008 Elliott OTI
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

(**
The OpenGL reference manuals can be found at http://www.opengl.org/documentation/specs/.

In GLCaml, OpenGL constants have the same names as in C, but are written in lower case.

OpenGL functions have the same names as in C, but the signatures may differ slightly. 
The parameters are translated according to the following table:

- GLboolean  	-> bool
- void    		-> unit
- GLvoid    	-> unit
- GLuint     	-> int
- GLint      	-> int
- GLintptr   	-> int
- GLenum     	-> int
- GLsizei   	-> int
- GLsizeiptr 	-> int
- GLfloat    	-> float
- GLdouble   	-> float
- GLchar     	-> int
- GLclampf   	-> float
- GLclampd   	-> float
- GLshort    	-> int
- GLubyte    	-> int
- GLbitfield 	-> int
- GLushort   	-> int
- GLbyte     	-> int
- GLstring		-> string
- GLbyte*    	-> int array
- GLubyte*    	-> int array
- void*    		-> 'a
- GLvoid*    	-> 'a
- GLvoid**   	-> 'a
- GLuint*    	-> int array
- GLint*    	-> int array
- GLfloat*   	-> float array
- GLdouble*  	-> float array
- GLchar*    	-> string
- GLchar**   	-> string array
- GLclampf*  	-> float array
- GLclampd*  	-> float array
- GLshort*   	-> int array
- GLushort*  	-> int array
- GLboolean*  	-> bool array
- GLboolean** 	-> word_matrix
- GLsizei*   	-> int array
- GLenum*    	-> int array


Void pointers are represented by the polymorphic type ['a], but in the FFI only strings, Bigarrays, or foreign-function interface bindings to C arrays 
are actually processed properly (such as [SDLCaml.surface_pixels] which returns in essence a pointer to an array containing the bitmap contents).
Passing other types will most likely result in a segfault. 

There is one function ([glEdgeFlagPointerListIBM]) which requires an array of arrays of Booleans. The array of array of GLbooleans is in GLCaml
in this single instance represented by a 2-dimensional Bigarray of 32-bit integers, so manual conversion from and to bools need to take place.
All other conversions are handled automatically by GLCaml.

The parameter conversion convention means that a lot of the OpenGL functions are superfluous in GLCaml, since they have the same Ocaml signature
despite having different C signatures. [glVertex2i] and [glVertex2s], for instance, take int and short arguments respectively in C, but both take native 
integers in Ocaml. Likewise [glVertex2f] (single-precision floats) and [glVertex2d] (double precision floats) both translate to having double precision float arguments
in the Ocaml bindings. This also means that precision may be lost or overflow may occur when using integer arguments for an OpenGL function that
uses 8-bit or 16-bit integers; likewise when using Ocaml floats for OpenGL functions using single-precision floats.

Note that most OpenGL implementations use single-precision floating point internally, even if the call is made with an API function using doubles.
OpenGL 3.0, due to be released in 2008, will only support single precision floating point.

*)

type byte_array =
    (int, Bigarray.int8_signed_elt, Bigarray.c_layout) Bigarray.Array1.t
type ubyte_array =
    (int, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
type short_array =
    (int, Bigarray.int16_signed_elt, Bigarray.c_layout) Bigarray.Array1.t
type ushort_array =
    (int, Bigarray.int16_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
type word_array =
    (int32, Bigarray.int32_elt, Bigarray.c_layout) Bigarray.Array1.t
type dword_array =
    (int64, Bigarray.int64_elt, Bigarray.c_layout) Bigarray.Array1.t
type int_array = (int, Bigarray.int_elt, Bigarray.c_layout) Bigarray.Array1.t
type float_array =
    (float, Bigarray.float32_elt, Bigarray.c_layout) Bigarray.Array1.t
type double_array =
    (float, Bigarray.float64_elt, Bigarray.c_layout) Bigarray.Array1.t
type byte_matrix =
    (int, Bigarray.int8_signed_elt, Bigarray.c_layout) Bigarray.Array2.t
type ubyte_matrix =
    (int, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array2.t
type short_matrix =
    (int, Bigarray.int16_signed_elt, Bigarray.c_layout) Bigarray.Array2.t
type ushort_matrix =
    (int, Bigarray.int16_unsigned_elt, Bigarray.c_layout) Bigarray.Array2.t
type word_matrix =
    (int32, Bigarray.int32_elt, Bigarray.c_layout) Bigarray.Array2.t
type dword_matrix =
    (int64, Bigarray.int64_elt, Bigarray.c_layout) Bigarray.Array2.t
type int_matrix =
    (int, Bigarray.int_elt, Bigarray.c_layout) Bigarray.Array2.t
type float_matrix =
    (float, Bigarray.float32_elt, Bigarray.c_layout) Bigarray.Array2.t
type double_matrix =
    (float, Bigarray.float64_elt, Bigarray.c_layout) Bigarray.Array2.t
val make_byte_array :
  int -> (int, Bigarray.int8_signed_elt, Bigarray.c_layout) Bigarray.Array1.t
val make_ubyte_array :
  int ->
  (int, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
val make_short_array :
  int ->
  (int, Bigarray.int16_signed_elt, Bigarray.c_layout) Bigarray.Array1.t
val make_ushort_array :
  int ->
  (int, Bigarray.int16_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
val make_word_array :
  int -> (int32, Bigarray.int32_elt, Bigarray.c_layout) Bigarray.Array1.t
val make_dword_array :
  int -> (int64, Bigarray.int64_elt, Bigarray.c_layout) Bigarray.Array1.t
val make_int_array :
  int -> (int, Bigarray.int_elt, Bigarray.c_layout) Bigarray.Array1.t
val make_float_array :
  int -> (float, Bigarray.float32_elt, Bigarray.c_layout) Bigarray.Array1.t
val make_double_array :
  int -> (float, Bigarray.float64_elt, Bigarray.c_layout) Bigarray.Array1.t
val make_byte_matrix :
  int ->
  int -> (int, Bigarray.int8_signed_elt, Bigarray.c_layout) Bigarray.Array2.t
val make_ubyte_matrix :
  int ->
  int ->
  (int, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array2.t
val make_short_matrix :
  int ->
  int ->
  (int, Bigarray.int16_signed_elt, Bigarray.c_layout) Bigarray.Array2.t
val make_ushort_matrix :
  int ->
  int ->
  (int, Bigarray.int16_unsigned_elt, Bigarray.c_layout) Bigarray.Array2.t
val make_word_matrix :
  int ->
  int -> (int32, Bigarray.int32_elt, Bigarray.c_layout) Bigarray.Array2.t
val make_dword_matrix :
  int ->
  int -> (int64, Bigarray.int64_elt, Bigarray.c_layout) Bigarray.Array2.t
val make_int_matrix :
  int -> int -> (int, Bigarray.int_elt, Bigarray.c_layout) Bigarray.Array2.t
val make_float_matrix :
  int ->
  int -> (float, Bigarray.float32_elt, Bigarray.c_layout) Bigarray.Array2.t
val make_double_matrix :
  int ->
  int -> (float, Bigarray.float64_elt, Bigarray.c_layout) Bigarray.Array2.t
val to_byte_array :
  int array ->
  (int, Bigarray.int8_signed_elt, Bigarray.c_layout) Bigarray.Array1.t
val to_ubyte_array :
  int array ->
  (int, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
val to_short_array :
  int array ->
  (int, Bigarray.int16_signed_elt, Bigarray.c_layout) Bigarray.Array1.t
val to_ushort_array :
  int array ->
  (int, Bigarray.int16_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
val to_word_array :
  int array ->
  (int32, Bigarray.int32_elt, Bigarray.c_layout) Bigarray.Array1.t
val to_dword_array :
  int array ->
  (int64, Bigarray.int64_elt, Bigarray.c_layout) Bigarray.Array1.t
val to_int_array :
  int array -> (int, Bigarray.int_elt, Bigarray.c_layout) Bigarray.Array1.t
val to_float_array :
  float array ->
  (float, Bigarray.float32_elt, Bigarray.c_layout) Bigarray.Array1.t
val to_double_array :
  float array ->
  (float, Bigarray.float64_elt, Bigarray.c_layout) Bigarray.Array1.t
val copy_byte_array : ('a, 'b, 'c) Bigarray.Array1.t -> 'a array -> unit
val copy_ubyte_array : ('a, 'b, 'c) Bigarray.Array1.t -> 'a array -> unit
val copy_short_array : ('a, 'b, 'c) Bigarray.Array1.t -> 'a array -> unit
val copy_ushort_array : ('a, 'b, 'c) Bigarray.Array1.t -> 'a array -> unit
val copy_word_array : (int32, 'a, 'b) Bigarray.Array1.t -> int array -> unit
val copy_dword_array : (int64, 'a, 'b) Bigarray.Array1.t -> int array -> unit
val copy_float_array :
  'a -> 'b -> ('c, 'd, 'e) Bigarray.Array1.t -> 'c array -> unit
val copy_double_array :
  'a -> 'b -> ('c, 'd, 'e) Bigarray.Array1.t -> 'c array -> unit
val to_string : (char, 'a, 'b) Bigarray.Array1.t -> string
val int_of_bool : bool -> int
val bool_of_int : int -> bool
val bool_to_int_array : bool array -> int array
val int_to_bool_array : int array -> bool array
val copy_to_bool_array : int array -> bool array -> unit array
val gl_constant_color : int
val gl_one_minus_constant_color : int
val gl_constant_alpha : int
val gl_one_minus_constant_alpha : int
val gl_blend_color : int
val gl_func_add : int
val gl_min : int
val gl_max : int
val gl_blend_equation : int
val gl_func_subtract : int
val gl_func_reverse_subtract : int
val gl_convolution_1d : int
val gl_convolution_2d : int
val gl_separable_2d : int
val gl_convolution_border_mode : int
val gl_convolution_filter_scale : int
val gl_convolution_filter_bias : int
val gl_reduce : int
val gl_convolution_format : int
val gl_convolution_width : int
val gl_convolution_height : int
val gl_max_convolution_width : int
val gl_max_convolution_height : int
val gl_post_convolution_red_scale : int
val gl_post_convolution_green_scale : int
val gl_post_convolution_blue_scale : int
val gl_post_convolution_alpha_scale : int
val gl_post_convolution_red_bias : int
val gl_post_convolution_green_bias : int
val gl_post_convolution_blue_bias : int
val gl_post_convolution_alpha_bias : int
val gl_histogram : int
val gl_proxy_histogram : int
val gl_histogram_width : int
val gl_histogram_format : int
val gl_histogram_red_size : int
val gl_histogram_green_size : int
val gl_histogram_blue_size : int
val gl_histogram_alpha_size : int
val gl_histogram_luminance_size : int
val gl_histogram_sink : int
val gl_minmax : int
val gl_minmax_format : int
val gl_minmax_sink : int
val gl_table_too_large : int
val gl_color_matrix : int
val gl_color_matrix_stack_depth : int
val gl_max_color_matrix_stack_depth : int
val gl_post_color_matrix_red_scale : int
val gl_post_color_matrix_green_scale : int
val gl_post_color_matrix_blue_scale : int
val gl_post_color_matrix_alpha_scale : int
val gl_post_color_matrix_red_bias : int
val gl_post_color_matrix_green_bias : int
val gl_post_color_matrix_blue_bias : int
val gl_post_color_matrix_alpha_bias : int
val gl_color_table : int
val gl_post_convolution_color_table : int
val gl_post_color_matrix_color_table : int
val gl_proxy_color_table : int
val gl_proxy_post_convolution_color_table : int
val gl_proxy_post_color_matrix_color_table : int
val gl_color_table_scale : int
val gl_color_table_bias : int
val gl_color_table_format : int
val gl_color_table_width : int
val gl_color_table_red_size : int
val gl_color_table_green_size : int
val gl_color_table_blue_size : int
val gl_color_table_alpha_size : int
val gl_color_table_luminance_size : int
val gl_color_table_intensity_size : int
val gl_ignore_border : int
val gl_constant_border : int
val gl_wrap_border : int
val gl_replicate_border : int
val gl_convolution_border_color : int
val gl_matrix_palette_arb : int
val gl_max_matrix_palette_stack_depth_arb : int
val gl_max_palette_matrices_arb : int
val gl_current_palette_matrix_arb : int
val gl_matrix_index_array_arb : int
val gl_current_matrix_index_arb : int
val gl_matrix_index_array_size_arb : int
val gl_matrix_index_array_type_arb : int
val gl_matrix_index_array_stride_arb : int
val gl_matrix_index_array_pointer_arb : int
val gl_texture0_arb : int
val gl_texture1_arb : int
val gl_texture2_arb : int
val gl_texture3_arb : int
val gl_texture4_arb : int
val gl_texture5_arb : int
val gl_texture6_arb : int
val gl_texture7_arb : int
val gl_texture8_arb : int
val gl_texture9_arb : int
val gl_texture10_arb : int
val gl_texture11_arb : int
val gl_texture12_arb : int
val gl_texture13_arb : int
val gl_texture14_arb : int
val gl_texture15_arb : int
val gl_texture16_arb : int
val gl_texture17_arb : int
val gl_texture18_arb : int
val gl_texture19_arb : int
val gl_texture20_arb : int
val gl_texture21_arb : int
val gl_texture22_arb : int
val gl_texture23_arb : int
val gl_texture24_arb : int
val gl_texture25_arb : int
val gl_texture26_arb : int
val gl_texture27_arb : int
val gl_texture28_arb : int
val gl_texture29_arb : int
val gl_texture30_arb : int
val gl_texture31_arb : int
val gl_active_texture_arb : int
val gl_client_active_texture_arb : int
val gl_max_texture_units_arb : int
val gl_max_vertex_units_arb : int
val gl_active_vertex_units_arb : int
val gl_weight_sum_unity_arb : int
val gl_vertex_blend_arb : int
val gl_current_weight_arb : int
val gl_weight_array_type_arb : int
val gl_weight_array_stride_arb : int
val gl_weight_array_size_arb : int
val gl_weight_array_pointer_arb : int
val gl_weight_array_arb : int
val gl_modelview0_arb : int
val gl_modelview1_arb : int
val gl_modelview2_arb : int
val gl_modelview3_arb : int
val gl_modelview4_arb : int
val gl_modelview5_arb : int
val gl_modelview6_arb : int
val gl_modelview7_arb : int
val gl_modelview8_arb : int
val gl_modelview9_arb : int
val gl_modelview10_arb : int
val gl_modelview11_arb : int
val gl_modelview12_arb : int
val gl_modelview13_arb : int
val gl_modelview14_arb : int
val gl_modelview15_arb : int
val gl_modelview16_arb : int
val gl_modelview17_arb : int
val gl_modelview18_arb : int
val gl_modelview19_arb : int
val gl_modelview20_arb : int
val gl_modelview21_arb : int
val gl_modelview22_arb : int
val gl_modelview23_arb : int
val gl_modelview24_arb : int
val gl_modelview25_arb : int
val gl_modelview26_arb : int
val gl_modelview27_arb : int
val gl_modelview28_arb : int
val gl_modelview29_arb : int
val gl_modelview30_arb : int
val gl_modelview31_arb : int
val gl_bump_rot_matrix_ati : int
val gl_bump_rot_matrix_size_ati : int
val gl_bump_num_tex_units_ati : int
val gl_bump_tex_units_ati : int
val gl_dudv_ati : int
val gl_du8dv8_ati : int
val gl_bump_envmap_ati : int
val gl_bump_target_ati : int
val gl_pn_triangles_ati : int
val gl_max_pn_triangles_tesselation_level_ati : int
val gl_pn_triangles_point_mode_ati : int
val gl_pn_triangles_normal_mode_ati : int
val gl_pn_triangles_tesselation_level_ati : int
val gl_pn_triangles_point_mode_linear_ati : int
val gl_pn_triangles_point_mode_cubic_ati : int
val gl_pn_triangles_normal_mode_linear_ati : int
val gl_pn_triangles_normal_mode_quadratic_ati : int
val gl_stencil_back_func_ati : int
val gl_stencil_back_fail_ati : int
val gl_stencil_back_pass_depth_fail_ati : int
val gl_stencil_back_pass_depth_pass_ati : int
val gl_compressed_rgb_3dc_ati : int
val gl_max_vertex_streams_ati : int
val gl_vertex_source_ati : int
val gl_vertex_stream0_ati : int
val gl_vertex_stream1_ati : int
val gl_vertex_stream2_ati : int
val gl_vertex_stream3_ati : int
val gl_vertex_stream4_ati : int
val gl_vertex_stream5_ati : int
val gl_vertex_stream6_ati : int
val gl_vertex_stream7_ati : int
val gl_texture_point_mode_atix : int
val gl_texture_point_one_coord_atix : int
val gl_texture_point_sprite_atix : int
val gl_point_sprite_cull_mode_atix : int
val gl_point_sprite_cull_center_atix : int
val gl_point_sprite_cull_clip_atix : int
val gl_modulate_add_atix : int
val gl_modulate_signed_add_atix : int
val gl_modulate_subtract_atix : int
val gl_secondary_color_atix : int
val gl_texture_output_rgb_atix : int
val gl_texture_output_alpha_atix : int
val gl_output_point_size_atix : int
val gl_cg_vertex_shader_ext : int
val gl_cg_fragment_shader_ext : int
val gl_depth_bounds_test_ext : int
val gl_depth_bounds_ext : int
val gl_fog_coordinate_source_ext : int
val gl_fog_coordinate_ext : int
val gl_fragment_depth_ext : int
val gl_current_fog_coordinate_ext : int
val gl_fog_coordinate_array_type_ext : int
val gl_fog_coordinate_array_stride_ext : int
val gl_fog_coordinate_array_pointer_ext : int
val gl_fog_coordinate_array_ext : int
val gl_pixel_pack_buffer_ext : int
val gl_pixel_unpack_buffer_ext : int
val gl_pixel_pack_buffer_binding_ext : int
val gl_pixel_unpack_buffer_binding_ext : int
val gl_color_sum_ext : int
val gl_current_secondary_color_ext : int
val gl_secondary_color_array_size_ext : int
val gl_secondary_color_array_type_ext : int
val gl_secondary_color_array_stride_ext : int
val gl_secondary_color_array_pointer_ext : int
val gl_secondary_color_array_ext : int
val gl_normal_map_ext : int
val gl_reflection_map_ext : int
val gl_texture_cube_map_ext : int
val gl_texture_binding_cube_map_ext : int
val gl_texture_cube_map_positive_x_ext : int
val gl_texture_cube_map_negative_x_ext : int
val gl_texture_cube_map_positive_y_ext : int
val gl_texture_cube_map_negative_y_ext : int
val gl_texture_cube_map_positive_z_ext : int
val gl_texture_cube_map_negative_z_ext : int
val gl_proxy_texture_cube_map_ext : int
val gl_max_cube_map_texture_size_ext : int
val gl_clamp_to_edge_ext : int
val gl_texture_rectangle_ext : int
val gl_texture_binding_rectangle_ext : int
val gl_proxy_texture_rectangle_ext : int
val gl_max_rectangle_texture_size_ext : int
val gl_vertex_shader_ext : int
val gl_vertex_shader_binding_ext : int
val gl_op_index_ext : int
val gl_op_negate_ext : int
val gl_op_dot3_ext : int
val gl_op_dot4_ext : int
val gl_op_mul_ext : int
val gl_op_add_ext : int
val gl_op_madd_ext : int
val gl_op_frac_ext : int
val gl_op_max_ext : int
val gl_op_min_ext : int
val gl_op_set_ge_ext : int
val gl_op_set_lt_ext : int
val gl_op_clamp_ext : int
val gl_op_floor_ext : int
val gl_op_round_ext : int
val gl_op_exp_base_2_ext : int
val gl_op_log_base_2_ext : int
val gl_op_power_ext : int
val gl_op_recip_ext : int
val gl_op_recip_sqrt_ext : int
val gl_op_sub_ext : int
val gl_op_cross_product_ext : int
val gl_op_multiply_matrix_ext : int
val gl_op_mov_ext : int
val gl_output_vertex_ext : int
val gl_output_color0_ext : int
val gl_output_color1_ext : int
val gl_output_texture_coord0_ext : int
val gl_output_texture_coord1_ext : int
val gl_output_texture_coord2_ext : int
val gl_output_texture_coord3_ext : int
val gl_output_texture_coord4_ext : int
val gl_output_texture_coord5_ext : int
val gl_output_texture_coord6_ext : int
val gl_output_texture_coord7_ext : int
val gl_output_texture_coord8_ext : int
val gl_output_texture_coord9_ext : int
val gl_output_texture_coord10_ext : int
val gl_output_texture_coord11_ext : int
val gl_output_texture_coord12_ext : int
val gl_output_texture_coord13_ext : int
val gl_output_texture_coord14_ext : int
val gl_output_texture_coord15_ext : int
val gl_output_texture_coord16_ext : int
val gl_output_texture_coord17_ext : int
val gl_output_texture_coord18_ext : int
val gl_output_texture_coord19_ext : int
val gl_output_texture_coord20_ext : int
val gl_output_texture_coord21_ext : int
val gl_output_texture_coord22_ext : int
val gl_output_texture_coord23_ext : int
val gl_output_texture_coord24_ext : int
val gl_output_texture_coord25_ext : int
val gl_output_texture_coord26_ext : int
val gl_output_texture_coord27_ext : int
val gl_output_texture_coord28_ext : int
val gl_output_texture_coord29_ext : int
val gl_output_texture_coord30_ext : int
val gl_output_texture_coord31_ext : int
val gl_output_fog_ext : int
val gl_scalar_ext : int
val gl_vector_ext : int
val gl_matrix_ext : int
val gl_variant_ext : int
val gl_invariant_ext : int
val gl_local_constant_ext : int
val gl_local_ext : int
val gl_max_vertex_shader_instructions_ext : int
val gl_max_vertex_shader_variants_ext : int
val gl_max_vertex_shader_invariants_ext : int
val gl_max_vertex_shader_local_constants_ext : int
val gl_max_vertex_shader_locals_ext : int
val gl_max_optimized_vertex_shader_instructions_ext : int
val gl_max_optimized_vertex_shader_variants_ext : int
val gl_max_optimized_vertex_shader_invariants_ext : int
val gl_max_optimized_vertex_shader_local_constants_ext : int
val gl_max_optimized_vertex_shader_locals_ext : int
val gl_vertex_shader_instructions_ext : int
val gl_vertex_shader_variants_ext : int
val gl_vertex_shader_invariants_ext : int
val gl_vertex_shader_local_constants_ext : int
val gl_vertex_shader_locals_ext : int
val gl_vertex_shader_optimized_ext : int
val gl_x_ext : int
val gl_y_ext : int
val gl_z_ext : int
val gl_w_ext : int
val gl_negative_x_ext : int
val gl_negative_y_ext : int
val gl_negative_z_ext : int
val gl_negative_w_ext : int
val gl_zero_ext : int
val gl_one_ext : int
val gl_negative_one_ext : int
val gl_normalized_range_ext : int
val gl_full_range_ext : int
val gl_current_vertex_ext : int
val gl_mvp_matrix_ext : int
val gl_variant_value_ext : int
val gl_variant_datatype_ext : int
val gl_variant_array_stride_ext : int
val gl_variant_array_type_ext : int
val gl_variant_array_ext : int
val gl_variant_array_pointer_ext : int
val gl_invariant_value_ext : int
val gl_invariant_datatype_ext : int
val gl_local_constant_value_ext : int
val gl_local_constant_datatype_ext : int
val gl_ktx_front_region : int
val gl_ktx_back_region : int
val gl_ktx_z_region : int
val gl_ktx_stencil_region : int
val gl_max_program_exec_instructions_nv : int
val gl_max_program_call_depth_nv : int
val gl_max_program_if_depth_nv : int
val gl_max_program_loop_depth_nv : int
val gl_max_program_loop_count_nv : int
val gl_multisample_3dfx : int
val gl_sample_buffers_3dfx : int
val gl_samples_3dfx : int
val gl_multisample_bit_3dfx : int
val gl_compressed_rgb_fxt1_3dfx : int
val gl_compressed_rgba_fxt1_3dfx : int
val gl_unpack_client_storage_apple : int
val gl_element_array_apple : int
val gl_element_array_type_apple : int
val gl_element_array_pointer_apple : int
val gl_draw_pixels_apple : int
val gl_fence_apple : int
val gl_half_apple : int
val gl_color_float_apple : int
val gl_rgba_float32_apple : int
val gl_rgb_float32_apple : int
val gl_alpha_float32_apple : int
val gl_intensity_float32_apple : int
val gl_luminance_float32_apple : int
val gl_luminance_alpha_float32_apple : int
val gl_rgba_float16_apple : int
val gl_rgb_float16_apple : int
val gl_alpha_float16_apple : int
val gl_intensity_float16_apple : int
val gl_luminance_float16_apple : int
val gl_luminance_alpha_float16_apple : int
val gl_min_pbuffer_viewport_dims_apple : int
val gl_light_model_specular_vector_apple : int
val gl_texture_storage_hint_apple : int
val gl_storage_private_apple : int
val gl_storage_cached_apple : int
val gl_storage_shared_apple : int
val gl_texture_range_length_apple : int
val gl_texture_range_pointer_apple : int
val gl_transform_hint_apple : int
val gl_vertex_array_binding_apple : int
val gl_vertex_array_range_apple : int
val gl_vertex_array_range_length_apple : int
val gl_vertex_array_storage_hint_apple : int
val gl_max_vertex_array_range_element_apple : int
val gl_vertex_array_range_pointer_apple : int
val gl_ycbcr_422_apple : int
val gl_unsigned_short_8_8_apple : int
val gl_unsigned_short_8_8_rev_apple : int
val gl_rgba_float_mode_arb : int
val gl_clamp_vertex_color_arb : int
val gl_clamp_fragment_color_arb : int
val gl_clamp_read_color_arb : int
val gl_fixed_only_arb : int
val gl_depth_component16_arb : int
val gl_depth_component24_arb : int
val gl_depth_component32_arb : int
val gl_texture_depth_size_arb : int
val gl_depth_texture_mode_arb : int
val gl_max_draw_buffers_arb : int
val gl_draw_buffer0_arb : int
val gl_draw_buffer1_arb : int
val gl_draw_buffer2_arb : int
val gl_draw_buffer3_arb : int
val gl_draw_buffer4_arb : int
val gl_draw_buffer5_arb : int
val gl_draw_buffer6_arb : int
val gl_draw_buffer7_arb : int
val gl_draw_buffer8_arb : int
val gl_draw_buffer9_arb : int
val gl_draw_buffer10_arb : int
val gl_draw_buffer11_arb : int
val gl_draw_buffer12_arb : int
val gl_draw_buffer13_arb : int
val gl_draw_buffer14_arb : int
val gl_draw_buffer15_arb : int
val gl_fragment_program_arb : int
val gl_program_alu_instructions_arb : int
val gl_program_tex_instructions_arb : int
val gl_program_tex_indirections_arb : int
val gl_program_native_alu_instructions_arb : int
val gl_program_native_tex_instructions_arb : int
val gl_program_native_tex_indirections_arb : int
val gl_max_program_alu_instructions_arb : int
val gl_max_program_tex_instructions_arb : int
val gl_max_program_tex_indirections_arb : int
val gl_max_program_native_alu_instructions_arb : int
val gl_max_program_native_tex_instructions_arb : int
val gl_max_program_native_tex_indirections_arb : int
val gl_max_texture_coords_arb : int
val gl_max_texture_image_units_arb : int
val gl_fragment_shader_arb : int
val gl_max_fragment_uniform_components_arb : int
val gl_fragment_shader_derivative_hint_arb : int
val gl_half_float_arb : int
val gl_multisample_arb : int
val gl_sample_alpha_to_coverage_arb : int
val gl_sample_alpha_to_one_arb : int
val gl_sample_coverage_arb : int
val gl_sample_buffers_arb : int
val gl_samples_arb : int
val gl_sample_coverage_value_arb : int
val gl_sample_coverage_invert_arb : int
val gl_multisample_bit_arb : int
val gl_query_counter_bits_arb : int
val gl_current_query_arb : int
val gl_query_result_arb : int
val gl_query_result_available_arb : int
val gl_samples_passed_arb : int
val gl_pixel_pack_buffer_arb : int
val gl_pixel_unpack_buffer_arb : int
val gl_pixel_pack_buffer_binding_arb : int
val gl_pixel_unpack_buffer_binding_arb : int
val gl_point_size_min_arb : int
val gl_point_size_max_arb : int
val gl_point_fade_threshold_size_arb : int
val gl_point_distance_attenuation_arb : int
val gl_point_sprite_arb : int
val gl_coord_replace_arb : int
val gl_program_object_arb : int
val gl_shader_object_arb : int
val gl_object_type_arb : int
val gl_object_subtype_arb : int
val gl_float_vec2_arb : int
val gl_float_vec3_arb : int
val gl_float_vec4_arb : int
val gl_int_vec2_arb : int
val gl_int_vec3_arb : int
val gl_int_vec4_arb : int
val gl_bool_arb : int
val gl_bool_vec2_arb : int
val gl_bool_vec3_arb : int
val gl_bool_vec4_arb : int
val gl_float_mat2_arb : int
val gl_float_mat3_arb : int
val gl_float_mat4_arb : int
val gl_sampler_1d_arb : int
val gl_sampler_2d_arb : int
val gl_sampler_3d_arb : int
val gl_sampler_cube_arb : int
val gl_sampler_1d_shadow_arb : int
val gl_sampler_2d_shadow_arb : int
val gl_sampler_2d_rect_arb : int
val gl_sampler_2d_rect_shadow_arb : int
val gl_object_delete_status_arb : int
val gl_object_compile_status_arb : int
val gl_object_link_status_arb : int
val gl_object_validate_status_arb : int
val gl_object_info_log_length_arb : int
val gl_object_attached_objects_arb : int
val gl_object_active_uniforms_arb : int
val gl_object_active_uniform_max_length_arb : int
val gl_object_shader_source_length_arb : int
val gl_shading_language_version_arb : int
val gl_texture_compare_mode_arb : int
val gl_texture_compare_func_arb : int
val gl_compare_r_to_texture_arb : int
val gl_texture_compare_fail_value_arb : int
val gl_clamp_to_border_arb : int
val gl_compressed_alpha_arb : int
val gl_compressed_luminance_arb : int
val gl_compressed_luminance_alpha_arb : int
val gl_compressed_intensity_arb : int
val gl_compressed_rgb_arb : int
val gl_compressed_rgba_arb : int
val gl_texture_compression_hint_arb : int
val gl_texture_compressed_image_size_arb : int
val gl_texture_compressed_arb : int
val gl_num_compressed_texture_formats_arb : int
val gl_compressed_texture_formats_arb : int
val gl_normal_map_arb : int
val gl_reflection_map_arb : int
val gl_texture_cube_map_arb : int
val gl_texture_binding_cube_map_arb : int
val gl_texture_cube_map_positive_x_arb : int
val gl_texture_cube_map_negative_x_arb : int
val gl_texture_cube_map_positive_y_arb : int
val gl_texture_cube_map_negative_y_arb : int
val gl_texture_cube_map_positive_z_arb : int
val gl_texture_cube_map_negative_z_arb : int
val gl_proxy_texture_cube_map_arb : int
val gl_max_cube_map_texture_size_arb : int
val gl_subtract_arb : int
val gl_combine_arb : int
val gl_combine_rgb_arb : int
val gl_combine_alpha_arb : int
val gl_rgb_scale_arb : int
val gl_add_signed_arb : int
val gl_interpolate_arb : int
val gl_constant_arb : int
val gl_primary_color_arb : int
val gl_previous_arb : int
val gl_source0_rgb_arb : int
val gl_source1_rgb_arb : int
val gl_source2_rgb_arb : int
val gl_source0_alpha_arb : int
val gl_source1_alpha_arb : int
val gl_source2_alpha_arb : int
val gl_operand0_rgb_arb : int
val gl_operand1_rgb_arb : int
val gl_operand2_rgb_arb : int
val gl_operand0_alpha_arb : int
val gl_operand1_alpha_arb : int
val gl_operand2_alpha_arb : int
val gl_dot3_rgb_arb : int
val gl_dot3_rgba_arb : int
val gl_rgba32f_arb : int
val gl_rgb32f_arb : int
val gl_alpha32f_arb : int
val gl_intensity32f_arb : int
val gl_luminance32f_arb : int
val gl_luminance_alpha32f_arb : int
val gl_rgba16f_arb : int
val gl_rgb16f_arb : int
val gl_alpha16f_arb : int
val gl_intensity16f_arb : int
val gl_luminance16f_arb : int
val gl_luminance_alpha16f_arb : int
val gl_texture_red_type_arb : int
val gl_texture_green_type_arb : int
val gl_texture_blue_type_arb : int
val gl_texture_alpha_type_arb : int
val gl_texture_luminance_type_arb : int
val gl_texture_intensity_type_arb : int
val gl_texture_depth_type_arb : int
val gl_unsigned_normalized_arb : int
val gl_mirrored_repeat_arb : int
val gl_texture_rectangle_arb : int
val gl_texture_binding_rectangle_arb : int
val gl_proxy_texture_rectangle_arb : int
val gl_max_rectangle_texture_size_arb : int
val gl_transpose_modelview_matrix_arb : int
val gl_transpose_projection_matrix_arb : int
val gl_transpose_texture_matrix_arb : int
val gl_transpose_color_matrix_arb : int
val gl_buffer_size_arb : int
val gl_buffer_usage_arb : int
val gl_array_buffer_arb : int
val gl_element_array_buffer_arb : int
val gl_array_buffer_binding_arb : int
val gl_element_array_buffer_binding_arb : int
val gl_vertex_array_buffer_binding_arb : int
val gl_normal_array_buffer_binding_arb : int
val gl_color_array_buffer_binding_arb : int
val gl_index_array_buffer_binding_arb : int
val gl_texture_coord_array_buffer_binding_arb : int
val gl_edge_flag_array_buffer_binding_arb : int
val gl_secondary_color_array_buffer_binding_arb : int
val gl_fog_coordinate_array_buffer_binding_arb : int
val gl_weight_array_buffer_binding_arb : int
val gl_vertex_attrib_array_buffer_binding_arb : int
val gl_read_only_arb : int
val gl_write_only_arb : int
val gl_read_write_arb : int
val gl_buffer_access_arb : int
val gl_buffer_mapped_arb : int
val gl_buffer_map_pointer_arb : int
val gl_stream_draw_arb : int
val gl_stream_read_arb : int
val gl_stream_copy_arb : int
val gl_static_draw_arb : int
val gl_static_read_arb : int
val gl_static_copy_arb : int
val gl_dynamic_draw_arb : int
val gl_dynamic_read_arb : int
val gl_dynamic_copy_arb : int
val gl_color_sum_arb : int
val gl_vertex_program_arb : int
val gl_vertex_attrib_array_enabled_arb : int
val gl_vertex_attrib_array_size_arb : int
val gl_vertex_attrib_array_stride_arb : int
val gl_vertex_attrib_array_type_arb : int
val gl_current_vertex_attrib_arb : int
val gl_program_length_arb : int
val gl_program_string_arb : int
val gl_max_program_matrix_stack_depth_arb : int
val gl_max_program_matrices_arb : int
val gl_current_matrix_stack_depth_arb : int
val gl_current_matrix_arb : int
val gl_vertex_program_point_size_arb : int
val gl_vertex_program_two_side_arb : int
val gl_vertex_attrib_array_pointer_arb : int
val gl_program_error_position_arb : int
val gl_program_binding_arb : int
val gl_max_vertex_attribs_arb : int
val gl_vertex_attrib_array_normalized_arb : int
val gl_program_error_string_arb : int
val gl_program_format_ascii_arb : int
val gl_program_format_arb : int
val gl_program_instructions_arb : int
val gl_max_program_instructions_arb : int
val gl_program_native_instructions_arb : int
val gl_max_program_native_instructions_arb : int
val gl_program_temporaries_arb : int
val gl_max_program_temporaries_arb : int
val gl_program_native_temporaries_arb : int
val gl_max_program_native_temporaries_arb : int
val gl_program_parameters_arb : int
val gl_max_program_parameters_arb : int
val gl_program_native_parameters_arb : int
val gl_max_program_native_parameters_arb : int
val gl_program_attribs_arb : int
val gl_max_program_attribs_arb : int
val gl_program_native_attribs_arb : int
val gl_max_program_native_attribs_arb : int
val gl_program_address_registers_arb : int
val gl_max_program_address_registers_arb : int
val gl_program_native_address_registers_arb : int
val gl_max_program_native_address_registers_arb : int
val gl_max_program_local_parameters_arb : int
val gl_max_program_env_parameters_arb : int
val gl_program_under_native_limits_arb : int
val gl_transpose_current_matrix_arb : int
val gl_matrix0_arb : int
val gl_matrix1_arb : int
val gl_matrix2_arb : int
val gl_matrix3_arb : int
val gl_matrix4_arb : int
val gl_matrix5_arb : int
val gl_matrix6_arb : int
val gl_matrix7_arb : int
val gl_matrix8_arb : int
val gl_matrix9_arb : int
val gl_matrix10_arb : int
val gl_matrix11_arb : int
val gl_matrix12_arb : int
val gl_matrix13_arb : int
val gl_matrix14_arb : int
val gl_matrix15_arb : int
val gl_matrix16_arb : int
val gl_matrix17_arb : int
val gl_matrix18_arb : int
val gl_matrix19_arb : int
val gl_matrix20_arb : int
val gl_matrix21_arb : int
val gl_matrix22_arb : int
val gl_matrix23_arb : int
val gl_matrix24_arb : int
val gl_matrix25_arb : int
val gl_matrix26_arb : int
val gl_matrix27_arb : int
val gl_matrix28_arb : int
val gl_matrix29_arb : int
val gl_matrix30_arb : int
val gl_matrix31_arb : int
val gl_vertex_shader_arb : int
val gl_max_vertex_uniform_components_arb : int
val gl_max_varying_floats_arb : int
val gl_max_combined_texture_image_units_arb : int
val gl_object_active_attributes_arb : int
val gl_object_active_attribute_max_length_arb : int
val gl_max_draw_buffers_ati : int
val gl_draw_buffer0_ati : int
val gl_draw_buffer1_ati : int
val gl_draw_buffer2_ati : int
val gl_draw_buffer3_ati : int
val gl_draw_buffer4_ati : int
val gl_draw_buffer5_ati : int
val gl_draw_buffer6_ati : int
val gl_draw_buffer7_ati : int
val gl_draw_buffer8_ati : int
val gl_draw_buffer9_ati : int
val gl_draw_buffer10_ati : int
val gl_draw_buffer11_ati : int
val gl_draw_buffer12_ati : int
val gl_draw_buffer13_ati : int
val gl_draw_buffer14_ati : int
val gl_draw_buffer15_ati : int
val gl_element_array_ati : int
val gl_element_array_type_ati : int
val gl_element_array_pointer_ati : int
val gl_red_bit_ati : int
val gl_2x_bit_ati : int
val gl_4x_bit_ati : int
val gl_green_bit_ati : int
val gl_comp_bit_ati : int
val gl_blue_bit_ati : int
val gl_8x_bit_ati : int
val gl_negate_bit_ati : int
val gl_bias_bit_ati : int
val gl_half_bit_ati : int
val gl_quarter_bit_ati : int
val gl_eighth_bit_ati : int
val gl_saturate_bit_ati : int
val gl_fragment_shader_ati : int
val gl_reg_0_ati : int
val gl_reg_1_ati : int
val gl_reg_2_ati : int
val gl_reg_3_ati : int
val gl_reg_4_ati : int
val gl_reg_5_ati : int
val gl_con_0_ati : int
val gl_con_1_ati : int
val gl_con_2_ati : int
val gl_con_3_ati : int
val gl_con_4_ati : int
val gl_con_5_ati : int
val gl_con_6_ati : int
val gl_con_7_ati : int
val gl_mov_ati : int
val gl_add_ati : int
val gl_mul_ati : int
val gl_sub_ati : int
val gl_dot3_ati : int
val gl_dot4_ati : int
val gl_mad_ati : int
val gl_lerp_ati : int
val gl_cnd_ati : int
val gl_cnd0_ati : int
val gl_dot2_add_ati : int
val gl_secondary_interpolator_ati : int
val gl_swizzle_str_ati : int
val gl_swizzle_stq_ati : int
val gl_swizzle_str_dr_ati : int
val gl_swizzle_stq_dq_ati : int
val gl_num_fragment_registers_ati : int
val gl_num_fragment_constants_ati : int
val gl_num_passes_ati : int
val gl_num_instructions_per_pass_ati : int
val gl_num_instructions_total_ati : int
val gl_num_input_interpolator_components_ati : int
val gl_num_loopback_components_ati : int
val gl_color_alpha_pairing_ati : int
val gl_swizzle_strq_ati : int
val gl_swizzle_strq_dq_ati : int
val gl_text_fragment_shader_ati : int
val gl_compressed_luminance_alpha_3dc_ati : int
val gl_modulate_add_ati : int
val gl_modulate_signed_add_ati : int
val gl_modulate_subtract_ati : int
val gl_rgba_float32_ati : int
val gl_rgb_float32_ati : int
val gl_alpha_float32_ati : int
val gl_intensity_float32_ati : int
val gl_luminance_float32_ati : int
val gl_luminance_alpha_float32_ati : int
val gl_rgba_float16_ati : int
val gl_rgb_float16_ati : int
val gl_alpha_float16_ati : int
val gl_intensity_float16_ati : int
val gl_luminance_float16_ati : int
val gl_luminance_alpha_float16_ati : int
val gl_mirror_clamp_ati : int
val gl_mirror_clamp_to_edge_ati : int
val gl_static_ati : int
val gl_dynamic_ati : int
val gl_preserve_ati : int
val gl_discard_ati : int
val gl_object_buffer_size_ati : int
val gl_object_buffer_usage_ati : int
val gl_array_object_buffer_ati : int
val gl_array_object_offset_ati : int
val gl_422_ext : int
val gl_422_rev_ext : int
val gl_422_average_ext : int
val gl_422_rev_average_ext : int
val gl_abgr_ext : int
val gl_bgr_ext : int
val gl_bgra_ext : int
val gl_max_vertex_bindable_uniforms_ext : int
val gl_max_fragment_bindable_uniforms_ext : int
val gl_max_geometry_bindable_uniforms_ext : int
val gl_max_bindable_uniform_size_ext : int
val gl_uniform_buffer_binding_ext : int
val gl_uniform_buffer_ext : int
val gl_constant_color_ext : int
val gl_one_minus_constant_color_ext : int
val gl_constant_alpha_ext : int
val gl_one_minus_constant_alpha_ext : int
val gl_blend_color_ext : int
val gl_blend_equation_rgb_ext : int
val gl_blend_equation_alpha_ext : int
val gl_blend_dst_rgb_ext : int
val gl_blend_src_rgb_ext : int
val gl_blend_dst_alpha_ext : int
val gl_blend_src_alpha_ext : int
val gl_func_add_ext : int
val gl_min_ext : int
val gl_max_ext : int
val gl_blend_equation_ext : int
val gl_func_subtract_ext : int
val gl_func_reverse_subtract_ext : int
val gl_clip_volume_clipping_hint_ext : int
val gl_cmyk_ext : int
val gl_cmyka_ext : int
val gl_pack_cmyk_hint_ext : int
val gl_unpack_cmyk_hint_ext : int
val gl_convolution_1d_ext : int
val gl_convolution_2d_ext : int
val gl_separable_2d_ext : int
val gl_convolution_border_mode_ext : int
val gl_convolution_filter_scale_ext : int
val gl_convolution_filter_bias_ext : int
val gl_reduce_ext : int
val gl_convolution_format_ext : int
val gl_convolution_width_ext : int
val gl_convolution_height_ext : int
val gl_max_convolution_width_ext : int
val gl_max_convolution_height_ext : int
val gl_post_convolution_red_scale_ext : int
val gl_post_convolution_green_scale_ext : int
val gl_post_convolution_blue_scale_ext : int
val gl_post_convolution_alpha_scale_ext : int
val gl_post_convolution_red_bias_ext : int
val gl_post_convolution_green_bias_ext : int
val gl_post_convolution_blue_bias_ext : int
val gl_post_convolution_alpha_bias_ext : int
val gl_tangent_array_ext : int
val gl_binormal_array_ext : int
val gl_current_tangent_ext : int
val gl_current_binormal_ext : int
val gl_tangent_array_type_ext : int
val gl_tangent_array_stride_ext : int
val gl_binormal_array_type_ext : int
val gl_binormal_array_stride_ext : int
val gl_tangent_array_pointer_ext : int
val gl_binormal_array_pointer_ext : int
val gl_map1_tangent_ext : int
val gl_map2_tangent_ext : int
val gl_map1_binormal_ext : int
val gl_map2_binormal_ext : int
val gl_fragment_lighting_ext : int
val gl_fragment_color_material_ext : int
val gl_fragment_color_material_face_ext : int
val gl_fragment_color_material_parameter_ext : int
val gl_max_fragment_lights_ext : int
val gl_max_active_lights_ext : int
val gl_current_raster_normal_ext : int
val gl_light_env_mode_ext : int
val gl_fragment_light_model_local_viewer_ext : int
val gl_fragment_light_model_two_side_ext : int
val gl_fragment_light_model_ambient_ext : int
val gl_fragment_light_model_normal_interpolation_ext : int
val gl_fragment_light0_ext : int
val gl_fragment_light7_ext : int
val gl_draw_framebuffer_binding_ext : int
val gl_read_framebuffer_ext : int
val gl_draw_framebuffer_ext : int
val gl_read_framebuffer_binding_ext : int
val gl_renderbuffer_samples_ext : int
val gl_framebuffer_incomplete_multisample_ext : int
val gl_max_samples_ext : int
val gl_invalid_framebuffer_operation_ext : int
val gl_max_renderbuffer_size_ext : int
val gl_framebuffer_binding_ext : int
val gl_renderbuffer_binding_ext : int
val gl_framebuffer_attachment_object_type_ext : int
val gl_framebuffer_attachment_object_name_ext : int
val gl_framebuffer_attachment_texture_level_ext : int
val gl_framebuffer_attachment_texture_cube_map_face_ext : int
val gl_framebuffer_attachment_texture_3d_zoffset_ext : int
val gl_framebuffer_complete_ext : int
val gl_framebuffer_incomplete_attachment_ext : int
val gl_framebuffer_incomplete_missing_attachment_ext : int
val gl_framebuffer_incomplete_dimensions_ext : int
val gl_framebuffer_incomplete_formats_ext : int
val gl_framebuffer_incomplete_draw_buffer_ext : int
val gl_framebuffer_incomplete_read_buffer_ext : int
val gl_framebuffer_unsupported_ext : int
val gl_max_color_attachments_ext : int
val gl_color_attachment0_ext : int
val gl_color_attachment1_ext : int
val gl_color_attachment2_ext : int
val gl_color_attachment3_ext : int
val gl_color_attachment4_ext : int
val gl_color_attachment5_ext : int
val gl_color_attachment6_ext : int
val gl_color_attachment7_ext : int
val gl_color_attachment8_ext : int
val gl_color_attachment9_ext : int
val gl_color_attachment10_ext : int
val gl_color_attachment11_ext : int
val gl_color_attachment12_ext : int
val gl_color_attachment13_ext : int
val gl_color_attachment14_ext : int
val gl_color_attachment15_ext : int
val gl_depth_attachment_ext : int
val gl_stencil_attachment_ext : int
val gl_framebuffer_ext : int
val gl_renderbuffer_ext : int
val gl_renderbuffer_width_ext : int
val gl_renderbuffer_height_ext : int
val gl_renderbuffer_internal_format_ext : int
val gl_stencil_index1_ext : int
val gl_stencil_index4_ext : int
val gl_stencil_index8_ext : int
val gl_stencil_index16_ext : int
val gl_renderbuffer_red_size_ext : int
val gl_renderbuffer_green_size_ext : int
val gl_renderbuffer_blue_size_ext : int
val gl_renderbuffer_alpha_size_ext : int
val gl_renderbuffer_depth_size_ext : int
val gl_renderbuffer_stencil_size_ext : int
val gl_framebuffer_srgb_ext : int
val gl_framebuffer_srgb_capable_ext : int
val gl_geometry_shader_ext : int
val gl_max_geometry_varying_components_ext : int
val gl_max_vertex_varying_components_ext : int
val gl_max_varying_components_ext : int
val gl_max_geometry_uniform_components_ext : int
val gl_max_geometry_output_vertices_ext : int
val gl_max_geometry_total_output_components_ext : int
val gl_geometry_vertices_out_ext : int
val gl_geometry_input_type_ext : int
val gl_geometry_output_type_ext : int
val gl_max_geometry_texture_image_units_ext : int
val gl_lines_adjacency_ext : int
val gl_line_strip_adjacency_ext : int
val gl_triangles_adjacency_ext : int
val gl_triangle_strip_adjacency_ext : int
val gl_framebuffer_attachment_layered_ext : int
val gl_framebuffer_incomplete_layer_targets_ext : int
val gl_framebuffer_incomplete_layer_count_ext : int
val gl_framebuffer_attachment_texture_layer_ext : int
val gl_program_point_size_ext : int
val gl_sampler_1d_array_ext : int
val gl_sampler_2d_array_ext : int
val gl_sampler_buffer_ext : int
val gl_sampler_1d_array_shadow_ext : int
val gl_sampler_2d_array_shadow_ext : int
val gl_sampler_cube_shadow_ext : int
val gl_unsigned_int_vec2_ext : int
val gl_unsigned_int_vec3_ext : int
val gl_unsigned_int_vec4_ext : int
val gl_int_sampler_1d_ext : int
val gl_int_sampler_2d_ext : int
val gl_int_sampler_3d_ext : int
val gl_int_sampler_cube_ext : int
val gl_int_sampler_2d_rect_ext : int
val gl_int_sampler_1d_array_ext : int
val gl_int_sampler_2d_array_ext : int
val gl_int_sampler_buffer_ext : int
val gl_unsigned_int_sampler_1d_ext : int
val gl_unsigned_int_sampler_2d_ext : int
val gl_unsigned_int_sampler_3d_ext : int
val gl_unsigned_int_sampler_cube_ext : int
val gl_unsigned_int_sampler_2d_rect_ext : int
val gl_unsigned_int_sampler_1d_array_ext : int
val gl_unsigned_int_sampler_2d_array_ext : int
val gl_unsigned_int_sampler_buffer_ext : int
val gl_vertex_attrib_array_integer_ext : int
val gl_histogram_ext : int
val gl_proxy_histogram_ext : int
val gl_histogram_width_ext : int
val gl_histogram_format_ext : int
val gl_histogram_red_size_ext : int
val gl_histogram_green_size_ext : int
val gl_histogram_blue_size_ext : int
val gl_histogram_alpha_size_ext : int
val gl_histogram_luminance_size_ext : int
val gl_histogram_sink_ext : int
val gl_minmax_ext : int
val gl_minmax_format_ext : int
val gl_minmax_sink_ext : int
val gl_fragment_material_ext : int
val gl_fragment_normal_ext : int
val gl_fragment_color_ext : int
val gl_attenuation_ext : int
val gl_shadow_attenuation_ext : int
val gl_texture_application_mode_ext : int
val gl_texture_light_ext : int
val gl_texture_material_face_ext : int
val gl_texture_material_parameter_ext : int
val gl_multisample_ext : int
val gl_sample_alpha_to_mask_ext : int
val gl_sample_alpha_to_one_ext : int
val gl_sample_mask_ext : int
val gl_1pass_ext : int
val gl_2pass_0_ext : int
val gl_2pass_1_ext : int
val gl_4pass_0_ext : int
val gl_4pass_1_ext : int
val gl_4pass_2_ext : int
val gl_4pass_3_ext : int
val gl_sample_buffers_ext : int
val gl_samples_ext : int
val gl_sample_mask_value_ext : int
val gl_sample_mask_invert_ext : int
val gl_sample_pattern_ext : int
val gl_multisample_bit_ext : int
val gl_depth_stencil_ext : int
val gl_unsigned_int_24_8_ext : int
val gl_depth24_stencil8_ext : int
val gl_texture_stencil_size_ext : int
val gl_r11f_g11f_b10f_ext : int
val gl_unsigned_int_10f_11f_11f_rev_ext : int
val gl_rgba_signed_components_ext : int
val gl_unsigned_byte_3_3_2_ext : int
val gl_unsigned_short_4_4_4_4_ext : int
val gl_unsigned_short_5_5_5_1_ext : int
val gl_unsigned_int_8_8_8_8_ext : int
val gl_unsigned_int_10_10_10_2_ext : int
val gl_proxy_texture_3d_ext : int
val gl_color_table_format_ext : int
val gl_color_table_width_ext : int
val gl_color_table_red_size_ext : int
val gl_color_table_green_size_ext : int
val gl_color_table_blue_size_ext : int
val gl_color_table_alpha_size_ext : int
val gl_color_table_luminance_size_ext : int
val gl_color_table_intensity_size_ext : int
val gl_texture_index_size_ext : int
val gl_pixel_transform_2d_ext : int
val gl_pixel_mag_filter_ext : int
val gl_pixel_min_filter_ext : int
val gl_pixel_cubic_weight_ext : int
val gl_cubic_ext : int
val gl_average_ext : int
val gl_pixel_transform_2d_stack_depth_ext : int
val gl_max_pixel_transform_2d_stack_depth_ext : int
val gl_pixel_transform_2d_matrix_ext : int
val gl_point_size_min_ext : int
val gl_point_size_max_ext : int
val gl_point_fade_threshold_size_ext : int
val gl_distance_attenuation_ext : int
val gl_polygon_offset_ext : int
val gl_polygon_offset_factor_ext : int
val gl_polygon_offset_bias_ext : int
val gl_light_model_color_control_ext : int
val gl_single_color_ext : int
val gl_separate_specular_color_ext : int
val gl_shared_texture_palette_ext : int
val gl_stencil_tag_bits_ext : int
val gl_stencil_clear_tag_value_ext : int
val gl_stencil_test_two_side_ext : int
val gl_active_stencil_face_ext : int
val gl_incr_wrap_ext : int
val gl_decr_wrap_ext : int
val gl_alpha4_ext : int
val gl_alpha8_ext : int
val gl_alpha12_ext : int
val gl_alpha16_ext : int
val gl_luminance4_ext : int
val gl_luminance8_ext : int
val gl_luminance12_ext : int
val gl_luminance16_ext : int
val gl_luminance4_alpha4_ext : int
val gl_luminance6_alpha2_ext : int
val gl_luminance8_alpha8_ext : int
val gl_luminance12_alpha4_ext : int
val gl_luminance12_alpha12_ext : int
val gl_luminance16_alpha16_ext : int
val gl_intensity_ext : int
val gl_intensity4_ext : int
val gl_intensity8_ext : int
val gl_intensity12_ext : int
val gl_intensity16_ext : int
val gl_rgb2_ext : int
val gl_rgb4_ext : int
val gl_rgb5_ext : int
val gl_rgb8_ext : int
val gl_rgb10_ext : int
val gl_rgb12_ext : int
val gl_rgb16_ext : int
val gl_rgba2_ext : int
val gl_rgba4_ext : int
val gl_rgb5_a1_ext : int
val gl_rgba8_ext : int
val gl_rgb10_a2_ext : int
val gl_rgba12_ext : int
val gl_rgba16_ext : int
val gl_texture_red_size_ext : int
val gl_texture_green_size_ext : int
val gl_texture_blue_size_ext : int
val gl_texture_alpha_size_ext : int
val gl_texture_luminance_size_ext : int
val gl_texture_intensity_size_ext : int
val gl_replace_ext : int
val gl_proxy_texture_1d_ext : int
val gl_proxy_texture_2d_ext : int
val gl_pack_skip_images_ext : int
val gl_pack_image_height_ext : int
val gl_unpack_skip_images_ext : int
val gl_unpack_image_height_ext : int
val gl_texture_3d_ext : int
val gl_texture_depth_ext : int
val gl_texture_wrap_r_ext : int
val gl_max_3d_texture_size_ext : int
val gl_texture_1d_array_ext : int
val gl_proxy_texture_1d_array_ext : int
val gl_texture_2d_array_ext : int
val gl_proxy_texture_2d_array_ext : int
val gl_texture_binding_1d_array_ext : int
val gl_texture_binding_2d_array_ext : int
val gl_max_array_texture_layers_ext : int
val gl_compare_ref_depth_to_texture_ext : int
val gl_texture_buffer_ext : int
val gl_max_texture_buffer_size_ext : int
val gl_texture_binding_buffer_ext : int
val gl_texture_buffer_data_store_binding_ext : int
val gl_texture_buffer_format_ext : int
val gl_compressed_luminance_latc1_ext : int
val gl_compressed_signed_luminance_latc1_ext : int
val gl_compressed_luminance_alpha_latc2_ext : int
val gl_compressed_signed_luminance_alpha_latc2_ext : int
val gl_compressed_red_rgtc1_ext : int
val gl_compressed_signed_red_rgtc1_ext : int
val gl_compressed_red_green_rgtc2_ext : int
val gl_compressed_signed_red_green_rgtc2_ext : int
val gl_compressed_rgb_s3tc_dxt1_ext : int
val gl_compressed_rgba_s3tc_dxt1_ext : int
val gl_compressed_rgba_s3tc_dxt3_ext : int
val gl_compressed_rgba_s3tc_dxt5_ext : int
val gl_texture_env0_ext : int
val gl_texture_env_shift_ext : int
val gl_env_blend_ext : int
val gl_env_add_ext : int
val gl_env_replace_ext : int
val gl_env_subtract_ext : int
val gl_texture_env_mode_alpha_ext : int
val gl_env_reverse_blend_ext : int
val gl_env_reverse_subtract_ext : int
val gl_env_copy_ext : int
val gl_env_modulate_ext : int
val gl_combine_ext : int
val gl_combine_rgb_ext : int
val gl_combine_alpha_ext : int
val gl_rgb_scale_ext : int
val gl_add_signed_ext : int
val gl_interpolate_ext : int
val gl_constant_ext : int
val gl_primary_color_ext : int
val gl_previous_ext : int
val gl_source0_rgb_ext : int
val gl_source1_rgb_ext : int
val gl_source2_rgb_ext : int
val gl_source0_alpha_ext : int
val gl_source1_alpha_ext : int
val gl_source2_alpha_ext : int
val gl_operand0_rgb_ext : int
val gl_operand1_rgb_ext : int
val gl_operand2_rgb_ext : int
val gl_operand0_alpha_ext : int
val gl_operand1_alpha_ext : int
val gl_operand2_alpha_ext : int
val gl_dot3_rgb_ext : int
val gl_dot3_rgba_ext : int
val gl_texture_max_anisotropy_ext : int
val gl_max_texture_max_anisotropy_ext : int
val gl_rgba32ui_ext : int
val gl_rgb32ui_ext : int
val gl_alpha32ui_ext : int
val gl_intensity32ui_ext : int
val gl_luminance32ui_ext : int
val gl_luminance_alpha32ui_ext : int
val gl_rgba16ui_ext : int
val gl_rgb16ui_ext : int
val gl_alpha16ui_ext : int
val gl_intensity16ui_ext : int
val gl_luminance16ui_ext : int
val gl_luminance_alpha16ui_ext : int
val gl_rgba8ui_ext : int
val gl_rgb8ui_ext : int
val gl_alpha8ui_ext : int
val gl_intensity8ui_ext : int
val gl_luminance8ui_ext : int
val gl_luminance_alpha8ui_ext : int
val gl_rgba32i_ext : int
val gl_rgb32i_ext : int
val gl_alpha32i_ext : int
val gl_intensity32i_ext : int
val gl_luminance32i_ext : int
val gl_luminance_alpha32i_ext : int
val gl_rgba16i_ext : int
val gl_rgb16i_ext : int
val gl_alpha16i_ext : int
val gl_intensity16i_ext : int
val gl_luminance16i_ext : int
val gl_luminance_alpha16i_ext : int
val gl_rgba8i_ext : int
val gl_rgb8i_ext : int
val gl_alpha8i_ext : int
val gl_intensity8i_ext : int
val gl_luminance8i_ext : int
val gl_luminance_alpha8i_ext : int
val gl_red_integer_ext : int
val gl_green_integer_ext : int
val gl_blue_integer_ext : int
val gl_alpha_integer_ext : int
val gl_rgb_integer_ext : int
val gl_rgba_integer_ext : int
val gl_bgr_integer_ext : int
val gl_bgra_integer_ext : int
val gl_luminance_integer_ext : int
val gl_luminance_alpha_integer_ext : int
val gl_rgba_integer_mode_ext : int
val gl_max_texture_lod_bias_ext : int
val gl_texture_filter_control_ext : int
val gl_texture_lod_bias_ext : int
val gl_mirror_clamp_ext : int
val gl_mirror_clamp_to_edge_ext : int
val gl_mirror_clamp_to_border_ext : int
val gl_texture_priority_ext : int
val gl_texture_resident_ext : int
val gl_texture_1d_binding_ext : int
val gl_texture_2d_binding_ext : int
val gl_texture_3d_binding_ext : int
val gl_perturb_ext : int
val gl_texture_normal_ext : int
val gl_rgb9_e5_ext : int
val gl_unsigned_int_5_9_9_9_rev_ext : int
val gl_texture_shared_size_ext : int
val gl_srgb_ext : int
val gl_srgb8_ext : int
val gl_srgb_alpha_ext : int
val gl_srgb8_alpha8_ext : int
val gl_sluminance_alpha_ext : int
val gl_sluminance8_alpha8_ext : int
val gl_sluminance_ext : int
val gl_sluminance8_ext : int
val gl_compressed_srgb_ext : int
val gl_compressed_srgb_alpha_ext : int
val gl_compressed_sluminance_ext : int
val gl_compressed_sluminance_alpha_ext : int
val gl_compressed_srgb_s3tc_dxt1_ext : int
val gl_compressed_srgb_alpha_s3tc_dxt1_ext : int
val gl_compressed_srgb_alpha_s3tc_dxt3_ext : int
val gl_compressed_srgb_alpha_s3tc_dxt5_ext : int
val gl_double_ext : int
val gl_vertex_array_ext : int
val gl_normal_array_ext : int
val gl_color_array_ext : int
val gl_index_array_ext : int
val gl_texture_coord_array_ext : int
val gl_edge_flag_array_ext : int
val gl_vertex_array_size_ext : int
val gl_vertex_array_type_ext : int
val gl_vertex_array_stride_ext : int
val gl_vertex_array_count_ext : int
val gl_normal_array_type_ext : int
val gl_normal_array_stride_ext : int
val gl_normal_array_count_ext : int
val gl_color_array_size_ext : int
val gl_color_array_type_ext : int
val gl_color_array_stride_ext : int
val gl_color_array_count_ext : int
val gl_index_array_type_ext : int
val gl_index_array_stride_ext : int
val gl_index_array_count_ext : int
val gl_texture_coord_array_size_ext : int
val gl_texture_coord_array_type_ext : int
val gl_texture_coord_array_stride_ext : int
val gl_texture_coord_array_count_ext : int
val gl_edge_flag_array_stride_ext : int
val gl_edge_flag_array_count_ext : int
val gl_vertex_array_pointer_ext : int
val gl_normal_array_pointer_ext : int
val gl_color_array_pointer_ext : int
val gl_index_array_pointer_ext : int
val gl_texture_coord_array_pointer_ext : int
val gl_edge_flag_array_pointer_ext : int
val gl_modelview0_stack_depth_ext : int
val gl_modelview0_matrix_ext : int
val gl_modelview0_ext : int
val gl_modelview1_stack_depth_ext : int
val gl_modelview1_matrix_ext : int
val gl_vertex_weighting_ext : int
val gl_modelview1_ext : int
val gl_current_vertex_weight_ext : int
val gl_vertex_weight_array_ext : int
val gl_vertex_weight_array_size_ext : int
val gl_vertex_weight_array_type_ext : int
val gl_vertex_weight_array_stride_ext : int
val gl_vertex_weight_array_pointer_ext : int
val gl_occlusion_test_result_hp : int
val gl_occlusion_test_hp : int
val gl_cull_vertex_ibm : int
val gl_raster_position_unclipped_ibm : int
val gl_all_static_data_ibm : int
val gl_static_vertex_array_ibm : int
val gl_mirrored_repeat_ibm : int
val gl_vertex_array_list_ibm : int
val gl_normal_array_list_ibm : int
val gl_color_array_list_ibm : int
val gl_index_array_list_ibm : int
val gl_texture_coord_array_list_ibm : int
val gl_edge_flag_array_list_ibm : int
val gl_fog_coordinate_array_list_ibm : int
val gl_secondary_color_array_list_ibm : int
val gl_vertex_array_list_stride_ibm : int
val gl_normal_array_list_stride_ibm : int
val gl_color_array_list_stride_ibm : int
val gl_index_array_list_stride_ibm : int
val gl_texture_coord_array_list_stride_ibm : int
val gl_edge_flag_array_list_stride_ibm : int
val gl_fog_coordinate_array_list_stride_ibm : int
val gl_secondary_color_array_list_stride_ibm : int
val gl_red_min_clamp_ingr : int
val gl_green_min_clamp_ingr : int
val gl_blue_min_clamp_ingr : int
val gl_alpha_min_clamp_ingr : int
val gl_red_max_clamp_ingr : int
val gl_green_max_clamp_ingr : int
val gl_blue_max_clamp_ingr : int
val gl_alpha_max_clamp_ingr : int
val gl_interlace_read_ingr : int
val gl_parallel_arrays_intel : int
val gl_vertex_array_parallel_pointers_intel : int
val gl_normal_array_parallel_pointers_intel : int
val gl_color_array_parallel_pointers_intel : int
val gl_texture_coord_array_parallel_pointers_intel : int
val gl_pack_invert_mesa : int
val gl_texture_1d_stack_mesax : int
val gl_texture_2d_stack_mesax : int
val gl_proxy_texture_1d_stack_mesax : int
val gl_proxy_texture_2d_stack_mesax : int
val gl_texture_1d_stack_binding_mesax : int
val gl_texture_2d_stack_binding_mesax : int
val gl_unsigned_short_8_8_mesa : int
val gl_unsigned_short_8_8_rev_mesa : int
val gl_ycbcr_mesa : int
val gl_depth_stencil_to_rgba_nv : int
val gl_depth_stencil_to_bgra_nv : int
val gl_depth_component32f_nv : int
val gl_depth32f_stencil8_nv : int
val gl_float_32_unsigned_int_24_8_rev_nv : int
val gl_depth_buffer_float_mode_nv : int
val gl_depth_clamp_nv : int
val gl_sample_count_bits_nv : int
val gl_current_sample_count_query_nv : int
val gl_query_result_nv : int
val gl_query_result_available_nv : int
val gl_sample_count_nv : int
val gl_eval_2d_nv : int
val gl_eval_triangular_2d_nv : int
val gl_map_tessellation_nv : int
val gl_map_attrib_u_order_nv : int
val gl_map_attrib_v_order_nv : int
val gl_eval_fractional_tessellation_nv : int
val gl_eval_vertex_attrib0_nv : int
val gl_eval_vertex_attrib1_nv : int
val gl_eval_vertex_attrib2_nv : int
val gl_eval_vertex_attrib3_nv : int
val gl_eval_vertex_attrib4_nv : int
val gl_eval_vertex_attrib5_nv : int
val gl_eval_vertex_attrib6_nv : int
val gl_eval_vertex_attrib7_nv : int
val gl_eval_vertex_attrib8_nv : int
val gl_eval_vertex_attrib9_nv : int
val gl_eval_vertex_attrib10_nv : int
val gl_eval_vertex_attrib11_nv : int
val gl_eval_vertex_attrib12_nv : int
val gl_eval_vertex_attrib13_nv : int
val gl_eval_vertex_attrib14_nv : int
val gl_eval_vertex_attrib15_nv : int
val gl_max_map_tessellation_nv : int
val gl_max_rational_eval_order_nv : int
val gl_all_completed_nv : int
val gl_fence_status_nv : int
val gl_fence_condition_nv : int
val gl_float_r_nv : int
val gl_float_rg_nv : int
val gl_float_rgb_nv : int
val gl_float_rgba_nv : int
val gl_float_r16_nv : int
val gl_float_r32_nv : int
val gl_float_rg16_nv : int
val gl_float_rg32_nv : int
val gl_float_rgb16_nv : int
val gl_float_rgb32_nv : int
val gl_float_rgba16_nv : int
val gl_float_rgba32_nv : int
val gl_texture_float_components_nv : int
val gl_float_clear_color_value_nv : int
val gl_float_rgba_mode_nv : int
val gl_fog_distance_mode_nv : int
val gl_eye_radial_nv : int
val gl_eye_plane_absolute_nv : int
val gl_max_fragment_program_local_parameters_nv : int
val gl_fragment_program_nv : int
val gl_max_texture_coords_nv : int
val gl_max_texture_image_units_nv : int
val gl_fragment_program_binding_nv : int
val gl_program_error_string_nv : int
val gl_renderbuffer_coverage_samples_nv : int
val gl_renderbuffer_color_samples_nv : int
val gl_max_multisample_coverage_modes_nv : int
val gl_multisample_coverage_modes_nv : int
val gl_geometry_program_nv : int
val gl_max_program_output_vertices_nv : int
val gl_max_program_total_output_components_nv : int
val gl_min_program_texel_offset_nv : int
val gl_max_program_texel_offset_nv : int
val gl_program_attrib_components_nv : int
val gl_program_result_components_nv : int
val gl_max_program_attrib_components_nv : int
val gl_max_program_result_components_nv : int
val gl_max_program_generic_attribs_nv : int
val gl_max_program_generic_results_nv : int
val gl_half_float_nv : int
val gl_max_shininess_nv : int
val gl_max_spot_exponent_nv : int
val gl_multisample_filter_hint_nv : int
val gl_pixel_counter_bits_nv : int
val gl_current_occlusion_query_id_nv : int
val gl_pixel_count_nv : int
val gl_pixel_count_available_nv : int
val gl_depth_stencil_nv : int
val gl_unsigned_int_24_8_nv : int
val gl_vertex_program_parameter_buffer_nv : int
val gl_geometry_program_parameter_buffer_nv : int
val gl_fragment_program_parameter_buffer_nv : int
val gl_max_program_parameter_buffer_bindings_nv : int
val gl_max_program_parameter_buffer_size_nv : int
val gl_write_pixel_data_range_nv : int
val gl_read_pixel_data_range_nv : int
val gl_write_pixel_data_range_length_nv : int
val gl_read_pixel_data_range_length_nv : int
val gl_write_pixel_data_range_pointer_nv : int
val gl_read_pixel_data_range_pointer_nv : int
val gl_point_sprite_nv : int
val gl_coord_replace_nv : int
val gl_point_sprite_r_mode_nv : int
val gl_primitive_restart_nv : int
val gl_primitive_restart_index_nv : int
val gl_register_combiners_nv : int
val gl_variable_a_nv : int
val gl_variable_b_nv : int
val gl_variable_c_nv : int
val gl_variable_d_nv : int
val gl_variable_e_nv : int
val gl_variable_f_nv : int
val gl_variable_g_nv : int
val gl_constant_color0_nv : int
val gl_constant_color1_nv : int
val gl_primary_color_nv : int
val gl_secondary_color_nv : int
val gl_spare0_nv : int
val gl_spare1_nv : int
val gl_discard_nv : int
val gl_e_times_f_nv : int
val gl_spare0_plus_secondary_color_nv : int
val gl_unsigned_identity_nv : int
val gl_unsigned_invert_nv : int
val gl_expand_normal_nv : int
val gl_expand_negate_nv : int
val gl_half_bias_normal_nv : int
val gl_half_bias_negate_nv : int
val gl_signed_identity_nv : int
val gl_signed_negate_nv : int
val gl_scale_by_two_nv : int
val gl_scale_by_four_nv : int
val gl_scale_by_one_half_nv : int
val gl_bias_by_negative_one_half_nv : int
val gl_combiner_input_nv : int
val gl_combiner_mapping_nv : int
val gl_combiner_component_usage_nv : int
val gl_combiner_ab_dot_product_nv : int
val gl_combiner_cd_dot_product_nv : int
val gl_combiner_mux_sum_nv : int
val gl_combiner_scale_nv : int
val gl_combiner_bias_nv : int
val gl_combiner_ab_output_nv : int
val gl_combiner_cd_output_nv : int
val gl_combiner_sum_output_nv : int
val gl_max_general_combiners_nv : int
val gl_num_general_combiners_nv : int
val gl_color_sum_clamp_nv : int
val gl_combiner0_nv : int
val gl_combiner1_nv : int
val gl_combiner2_nv : int
val gl_combiner3_nv : int
val gl_combiner4_nv : int
val gl_combiner5_nv : int
val gl_combiner6_nv : int
val gl_combiner7_nv : int
val gl_per_stage_constants_nv : int
val gl_emboss_light_nv : int
val gl_emboss_constant_nv : int
val gl_emboss_map_nv : int
val gl_normal_map_nv : int
val gl_reflection_map_nv : int
val gl_combine4_nv : int
val gl_source3_rgb_nv : int
val gl_source3_alpha_nv : int
val gl_operand3_rgb_nv : int
val gl_operand3_alpha_nv : int
val gl_texture_unsigned_remap_mode_nv : int
val gl_texture_rectangle_nv : int
val gl_texture_binding_rectangle_nv : int
val gl_proxy_texture_rectangle_nv : int
val gl_max_rectangle_texture_size_nv : int
val gl_offset_texture_rectangle_nv : int
val gl_offset_texture_rectangle_scale_nv : int
val gl_dot_product_texture_rectangle_nv : int
val gl_rgba_unsigned_dot_product_mapping_nv : int
val gl_unsigned_int_s8_s8_8_8_nv : int
val gl_unsigned_int_8_8_s8_s8_rev_nv : int
val gl_dsdt_mag_intensity_nv : int
val gl_shader_consistent_nv : int
val gl_texture_shader_nv : int
val gl_shader_operation_nv : int
val gl_cull_modes_nv : int
val gl_offset_texture_matrix_nv : int
val gl_offset_texture_scale_nv : int
val gl_offset_texture_bias_nv : int
val gl_previous_texture_input_nv : int
val gl_const_eye_nv : int
val gl_pass_through_nv : int
val gl_cull_fragment_nv : int
val gl_offset_texture_2d_nv : int
val gl_dependent_ar_texture_2d_nv : int
val gl_dependent_gb_texture_2d_nv : int
val gl_dot_product_nv : int
val gl_dot_product_depth_replace_nv : int
val gl_dot_product_texture_2d_nv : int
val gl_dot_product_texture_cube_map_nv : int
val gl_dot_product_diffuse_cube_map_nv : int
val gl_dot_product_reflect_cube_map_nv : int
val gl_dot_product_const_eye_reflect_cube_map_nv : int
val gl_hilo_nv : int
val gl_dsdt_nv : int
val gl_dsdt_mag_nv : int
val gl_dsdt_mag_vib_nv : int
val gl_hilo16_nv : int
val gl_signed_hilo_nv : int
val gl_signed_hilo16_nv : int
val gl_signed_rgba_nv : int
val gl_signed_rgba8_nv : int
val gl_signed_rgb_nv : int
val gl_signed_rgb8_nv : int
val gl_signed_luminance_nv : int
val gl_signed_luminance8_nv : int
val gl_signed_luminance_alpha_nv : int
val gl_signed_luminance8_alpha8_nv : int
val gl_signed_alpha_nv : int
val gl_signed_alpha8_nv : int
val gl_signed_intensity_nv : int
val gl_signed_intensity8_nv : int
val gl_dsdt8_nv : int
val gl_dsdt8_mag8_nv : int
val gl_dsdt8_mag8_intensity8_nv : int
val gl_signed_rgb_unsigned_alpha_nv : int
val gl_signed_rgb8_unsigned_alpha8_nv : int
val gl_hi_scale_nv : int
val gl_lo_scale_nv : int
val gl_ds_scale_nv : int
val gl_dt_scale_nv : int
val gl_magnitude_scale_nv : int
val gl_vibrance_scale_nv : int
val gl_hi_bias_nv : int
val gl_lo_bias_nv : int
val gl_ds_bias_nv : int
val gl_dt_bias_nv : int
val gl_magnitude_bias_nv : int
val gl_vibrance_bias_nv : int
val gl_texture_border_values_nv : int
val gl_texture_hi_size_nv : int
val gl_texture_lo_size_nv : int
val gl_texture_ds_size_nv : int
val gl_texture_dt_size_nv : int
val gl_texture_mag_size_nv : int
val gl_dot_product_texture_3d_nv : int
val gl_offset_projective_texture_2d_nv : int
val gl_offset_projective_texture_2d_scale_nv : int
val gl_offset_projective_texture_rectangle_nv : int
val gl_offset_projective_texture_rectangle_scale_nv : int
val gl_offset_hilo_texture_2d_nv : int
val gl_offset_hilo_texture_rectangle_nv : int
val gl_offset_hilo_projective_texture_2d_nv : int
val gl_offset_hilo_projective_texture_rectangle_nv : int
val gl_dependent_hilo_texture_2d_nv : int
val gl_dependent_rgb_texture_3d_nv : int
val gl_dependent_rgb_texture_cube_map_nv : int
val gl_dot_product_pass_through_nv : int
val gl_dot_product_texture_1d_nv : int
val gl_dot_product_affine_depth_replace_nv : int
val gl_hilo8_nv : int
val gl_signed_hilo8_nv : int
val gl_force_blue_to_one_nv : int
val gl_back_primary_color_nv : int
val gl_back_secondary_color_nv : int
val gl_texture_coord_nv : int
val gl_clip_distance_nv : int
val gl_vertex_id_nv : int
val gl_primitive_id_nv : int
val gl_generic_attrib_nv : int
val gl_transform_feedback_attribs_nv : int
val gl_transform_feedback_buffer_mode_nv : int
val gl_max_transform_feedback_separate_components_nv : int
val gl_active_varyings_nv : int
val gl_active_varying_max_length_nv : int
val gl_transform_feedback_varyings_nv : int
val gl_transform_feedback_buffer_start_nv : int
val gl_transform_feedback_buffer_size_nv : int
val gl_transform_feedback_record_nv : int
val gl_primitives_generated_nv : int
val gl_transform_feedback_primitives_written_nv : int
val gl_rasterizer_discard_nv : int
val gl_max_transform_feedback_interleaved_components_nv : int
val gl_max_transform_feedback_separate_attribs_nv : int
val gl_interleaved_attribs_nv : int
val gl_separate_attribs_nv : int
val gl_transform_feedback_buffer_nv : int
val gl_transform_feedback_buffer_binding_nv : int
val gl_vertex_array_range_nv : int
val gl_vertex_array_range_length_nv : int
val gl_vertex_array_range_valid_nv : int
val gl_max_vertex_array_range_element_nv : int
val gl_vertex_array_range_pointer_nv : int
val gl_vertex_array_range_without_flush_nv : int
val gl_vertex_program_nv : int
val gl_vertex_state_program_nv : int
val gl_attrib_array_size_nv : int
val gl_attrib_array_stride_nv : int
val gl_attrib_array_type_nv : int
val gl_current_attrib_nv : int
val gl_program_length_nv : int
val gl_program_string_nv : int
val gl_modelview_projection_nv : int
val gl_identity_nv : int
val gl_inverse_nv : int
val gl_transpose_nv : int
val gl_inverse_transpose_nv : int
val gl_max_track_matrix_stack_depth_nv : int
val gl_max_track_matrices_nv : int
val gl_matrix0_nv : int
val gl_matrix1_nv : int
val gl_matrix2_nv : int
val gl_matrix3_nv : int
val gl_matrix4_nv : int
val gl_matrix5_nv : int
val gl_matrix6_nv : int
val gl_matrix7_nv : int
val gl_current_matrix_stack_depth_nv : int
val gl_current_matrix_nv : int
val gl_vertex_program_point_size_nv : int
val gl_vertex_program_two_side_nv : int
val gl_program_parameter_nv : int
val gl_attrib_array_pointer_nv : int
val gl_program_target_nv : int
val gl_program_resident_nv : int
val gl_track_matrix_nv : int
val gl_track_matrix_transform_nv : int
val gl_vertex_program_binding_nv : int
val gl_program_error_position_nv : int
val gl_vertex_attrib_array0_nv : int
val gl_vertex_attrib_array1_nv : int
val gl_vertex_attrib_array2_nv : int
val gl_vertex_attrib_array3_nv : int
val gl_vertex_attrib_array4_nv : int
val gl_vertex_attrib_array5_nv : int
val gl_vertex_attrib_array6_nv : int
val gl_vertex_attrib_array7_nv : int
val gl_vertex_attrib_array8_nv : int
val gl_vertex_attrib_array9_nv : int
val gl_vertex_attrib_array10_nv : int
val gl_vertex_attrib_array11_nv : int
val gl_vertex_attrib_array12_nv : int
val gl_vertex_attrib_array13_nv : int
val gl_vertex_attrib_array14_nv : int
val gl_vertex_attrib_array15_nv : int
val gl_map1_vertex_attrib0_4_nv : int
val gl_map1_vertex_attrib1_4_nv : int
val gl_map1_vertex_attrib2_4_nv : int
val gl_map1_vertex_attrib3_4_nv : int
val gl_map1_vertex_attrib4_4_nv : int
val gl_map1_vertex_attrib5_4_nv : int
val gl_map1_vertex_attrib6_4_nv : int
val gl_map1_vertex_attrib7_4_nv : int
val gl_map1_vertex_attrib8_4_nv : int
val gl_map1_vertex_attrib9_4_nv : int
val gl_map1_vertex_attrib10_4_nv : int
val gl_map1_vertex_attrib11_4_nv : int
val gl_map1_vertex_attrib12_4_nv : int
val gl_map1_vertex_attrib13_4_nv : int
val gl_map1_vertex_attrib14_4_nv : int
val gl_map1_vertex_attrib15_4_nv : int
val gl_map2_vertex_attrib0_4_nv : int
val gl_map2_vertex_attrib1_4_nv : int
val gl_map2_vertex_attrib2_4_nv : int
val gl_map2_vertex_attrib3_4_nv : int
val gl_map2_vertex_attrib4_4_nv : int
val gl_map2_vertex_attrib5_4_nv : int
val gl_map2_vertex_attrib6_4_nv : int
val gl_map2_vertex_attrib7_4_nv : int
val gl_map2_vertex_attrib8_4_nv : int
val gl_map2_vertex_attrib9_4_nv : int
val gl_map2_vertex_attrib10_4_nv : int
val gl_map2_vertex_attrib11_4_nv : int
val gl_map2_vertex_attrib12_4_nv : int
val gl_map2_vertex_attrib13_4_nv : int
val gl_map2_vertex_attrib14_4_nv : int
val gl_map2_vertex_attrib15_4_nv : int
val gl_max_vertex_texture_image_units_arb : int
val gl_palette4_rgb8_oes : int
val gl_palette4_rgba8_oes : int
val gl_palette4_r5_g6_b5_oes : int
val gl_palette4_rgba4_oes : int
val gl_palette4_rgb5_a1_oes : int
val gl_palette8_rgb8_oes : int
val gl_palette8_rgba8_oes : int
val gl_palette8_r5_g6_b5_oes : int
val gl_palette8_rgba4_oes : int
val gl_palette8_rgb5_a1_oes : int
val gl_implementation_color_read_type_oes : int
val gl_implementation_color_read_format_oes : int
val gl_interlace_oml : int
val gl_interlace_read_oml : int
val gl_pack_resample_oml : int
val gl_unpack_resample_oml : int
val gl_resample_replicate_oml : int
val gl_resample_zero_fill_oml : int
val gl_resample_average_oml : int
val gl_resample_decimate_oml : int
val gl_format_subsample_24_24_oml : int
val gl_format_subsample_244_244_oml : int
val gl_prefer_doublebuffer_hint_pgi : int
val gl_conserve_memory_hint_pgi : int
val gl_reclaim_memory_hint_pgi : int
val gl_native_graphics_handle_pgi : int
val gl_native_graphics_begin_hint_pgi : int
val gl_native_graphics_end_hint_pgi : int
val gl_always_fast_hint_pgi : int
val gl_always_soft_hint_pgi : int
val gl_allow_draw_obj_hint_pgi : int
val gl_allow_draw_win_hint_pgi : int
val gl_allow_draw_frg_hint_pgi : int
val gl_allow_draw_mem_hint_pgi : int
val gl_strict_depthfunc_hint_pgi : int
val gl_strict_lighting_hint_pgi : int
val gl_strict_scissor_hint_pgi : int
val gl_full_stipple_hint_pgi : int
val gl_clip_near_hint_pgi : int
val gl_clip_far_hint_pgi : int
val gl_wide_line_hint_pgi : int
val gl_back_normals_hint_pgi : int
val gl_vertex23_bit_pgi : int
val gl_vertex4_bit_pgi : int
val gl_color3_bit_pgi : int
val gl_color4_bit_pgi : int
val gl_edgeflag_bit_pgi : int
val gl_index_bit_pgi : int
val gl_mat_ambient_bit_pgi : int
val gl_vertex_data_hint_pgi : int
val gl_vertex_consistent_hint_pgi : int
val gl_material_side_hint_pgi : int
val gl_max_vertex_hint_pgi : int
val gl_mat_ambient_and_diffuse_bit_pgi : int
val gl_mat_diffuse_bit_pgi : int
val gl_mat_emission_bit_pgi : int
val gl_mat_color_indexes_bit_pgi : int
val gl_mat_shininess_bit_pgi : int
val gl_mat_specular_bit_pgi : int
val gl_normal_bit_pgi : int
val gl_texcoord1_bit_pgi : int
val gl_texcoord2_bit_pgi : int
val gl_texcoord3_bit_pgi : int
val gl_screen_coordinates_rend : int
val gl_inverted_screen_w_rend : int
val gl_rgb_s3tc : int
val gl_rgb4_s3tc : int
val gl_rgba_s3tc : int
val gl_rgba4_s3tc : int
val gl_rgba_dxt5_s3tc : int
val gl_rgba4_dxt5_s3tc : int
val gl_color_matrix_sgi : int
val gl_color_matrix_stack_depth_sgi : int
val gl_max_color_matrix_stack_depth_sgi : int
val gl_post_color_matrix_red_scale_sgi : int
val gl_post_color_matrix_green_scale_sgi : int
val gl_post_color_matrix_blue_scale_sgi : int
val gl_post_color_matrix_alpha_scale_sgi : int
val gl_post_color_matrix_red_bias_sgi : int
val gl_post_color_matrix_green_bias_sgi : int
val gl_post_color_matrix_blue_bias_sgi : int
val gl_post_color_matrix_alpha_bias_sgi : int
val gl_color_table_sgi : int
val gl_post_convolution_color_table_sgi : int
val gl_post_color_matrix_color_table_sgi : int
val gl_proxy_color_table_sgi : int
val gl_proxy_post_convolution_color_table_sgi : int
val gl_proxy_post_color_matrix_color_table_sgi : int
val gl_color_table_scale_sgi : int
val gl_color_table_bias_sgi : int
val gl_color_table_format_sgi : int
val gl_color_table_width_sgi : int
val gl_color_table_red_size_sgi : int
val gl_color_table_green_size_sgi : int
val gl_color_table_blue_size_sgi : int
val gl_color_table_alpha_size_sgi : int
val gl_color_table_luminance_size_sgi : int
val gl_color_table_intensity_size_sgi : int
val gl_extended_range_sgis : int
val gl_min_red_sgis : int
val gl_max_red_sgis : int
val gl_min_green_sgis : int
val gl_max_green_sgis : int
val gl_min_blue_sgis : int
val gl_max_blue_sgis : int
val gl_min_alpha_sgis : int
val gl_max_alpha_sgis : int
val gl_generate_mipmap_sgis : int
val gl_generate_mipmap_hint_sgis : int
val gl_multisample_sgis : int
val gl_sample_alpha_to_mask_sgis : int
val gl_sample_alpha_to_one_sgis : int
val gl_sample_mask_sgis : int
val gl_1pass_sgis : int
val gl_2pass_0_sgis : int
val gl_2pass_1_sgis : int
val gl_4pass_0_sgis : int
val gl_4pass_1_sgis : int
val gl_4pass_2_sgis : int
val gl_4pass_3_sgis : int
val gl_sample_buffers_sgis : int
val gl_samples_sgis : int
val gl_sample_mask_value_sgis : int
val gl_sample_mask_invert_sgis : int
val gl_sample_pattern_sgis : int
val gl_clamp_to_border_sgis : int
val gl_clamp_to_edge_sgis : int
val gl_texture_min_lod_sgis : int
val gl_texture_max_lod_sgis : int
val gl_texture_base_level_sgis : int
val gl_texture_max_level_sgis : int
val gl_texture_color_table_sgi : int
val gl_proxy_texture_color_table_sgi : int
val gl_async_marker_sgix : int
val gl_async_histogram_sgix : int
val gl_max_async_histogram_sgix : int
val gl_async_tex_image_sgix : int
val gl_async_draw_pixels_sgix : int
val gl_async_read_pixels_sgix : int
val gl_max_async_tex_image_sgix : int
val gl_max_async_draw_pixels_sgix : int
val gl_max_async_read_pixels_sgix : int
val gl_alpha_min_sgix : int
val gl_alpha_max_sgix : int
val gl_depth_component16_sgix : int
val gl_depth_component24_sgix : int
val gl_depth_component32_sgix : int
val gl_fog_offset_sgix : int
val gl_fog_offset_value_sgix : int
val gl_texture_fog_sgix : int
val gl_fog_patchy_factor_sgix : int
val gl_fragment_fog_sgix : int
val gl_interlace_sgix : int
val gl_pack_resample_sgix : int
val gl_unpack_resample_sgix : int
val gl_resample_decimate_sgix : int
val gl_resample_replicate_sgix : int
val gl_resample_zero_fill_sgix : int
val gl_texture_compare_sgix : int
val gl_texture_compare_operator_sgix : int
val gl_texture_lequal_r_sgix : int
val gl_texture_gequal_r_sgix : int
val gl_shadow_ambient_sgix : int
val gl_texture_max_clamp_s_sgix : int
val gl_texture_max_clamp_t_sgix : int
val gl_texture_max_clamp_r_sgix : int
val gl_texture_multi_buffer_hint_sgix : int
val gl_rgb_signed_sgix : int
val gl_rgba_signed_sgix : int
val gl_alpha_signed_sgix : int
val gl_luminance_signed_sgix : int
val gl_intensity_signed_sgix : int
val gl_luminance_alpha_signed_sgix : int
val gl_rgb16_signed_sgix : int
val gl_rgba16_signed_sgix : int
val gl_alpha16_signed_sgix : int
val gl_luminance16_signed_sgix : int
val gl_intensity16_signed_sgix : int
val gl_luminance16_alpha16_signed_sgix : int
val gl_rgb_extended_range_sgix : int
val gl_rgba_extended_range_sgix : int
val gl_alpha_extended_range_sgix : int
val gl_luminance_extended_range_sgix : int
val gl_intensity_extended_range_sgix : int
val gl_luminance_alpha_extended_range_sgix : int
val gl_rgb16_extended_range_sgix : int
val gl_rgba16_extended_range_sgix : int
val gl_alpha16_extended_range_sgix : int
val gl_luminance16_extended_range_sgix : int
val gl_intensity16_extended_range_sgix : int
val gl_luminance16_alpha16_extended_range_sgix : int
val gl_min_luminance_sgis : int
val gl_max_luminance_sgis : int
val gl_min_intensity_sgis : int
val gl_max_intensity_sgis : int
val gl_post_texture_filter_bias_sgix : int
val gl_post_texture_filter_scale_sgix : int
val gl_post_texture_filter_bias_range_sgix : int
val gl_post_texture_filter_scale_range_sgix : int
val gl_vertex_preclip_sgix : int
val gl_vertex_preclip_hint_sgix : int
val gl_wrap_border_sun : int
val gl_global_alpha_sun : int
val gl_global_alpha_factor_sun : int
val gl_quad_mesh_sun : int
val gl_triangle_mesh_sun : int
val gl_slice_accum_sun : int
val gl_restart_sun : int
val gl_replace_middle_sun : int
val gl_replace_oldest_sun : int
val gl_triangle_list_sun : int
val gl_replacement_code_sun : int
val gl_replacement_code_array_sun : int
val gl_replacement_code_array_type_sun : int
val gl_replacement_code_array_stride_sun : int
val gl_replacement_code_array_pointer_sun : int
val gl_r1ui_v3f_sun : int
val gl_r1ui_c4ub_v3f_sun : int
val gl_r1ui_c3f_v3f_sun : int
val gl_r1ui_n3f_v3f_sun : int
val gl_r1ui_c4f_n3f_v3f_sun : int
val gl_r1ui_t2f_v3f_sun : int
val gl_r1ui_t2f_n3f_v3f_sun : int
val gl_r1ui_t2f_c4f_n3f_v3f_sun : int
val gl_unpack_constant_data_sunx : int
val gl_texture_constant_data_sunx : int
val gl_phong_win : int
val gl_phong_hint_win : int
val gl_fog_specular_texture_win : int
val gl_accum : int
val gl_load : int
val gl_return : int
val gl_mult : int
val gl_add : int
val gl_never : int
val gl_less : int
val gl_equal : int
val gl_lequal : int
val gl_greater : int
val gl_notequal : int
val gl_gequal : int
val gl_always : int
val gl_current_bit : int
val gl_point_bit : int
val gl_line_bit : int
val gl_polygon_bit : int
val gl_polygon_stipple_bit : int
val gl_pixel_mode_bit : int
val gl_lighting_bit : int
val gl_fog_bit : int
val gl_depth_buffer_bit : int
val gl_accum_buffer_bit : int
val gl_stencil_buffer_bit : int
val gl_viewport_bit : int
val gl_transform_bit : int
val gl_enable_bit : int
val gl_color_buffer_bit : int
val gl_hint_bit : int
val gl_eval_bit : int
val gl_list_bit : int
val gl_texture_bit : int
val gl_scissor_bit : int
val gl_all_attrib_bits : int
val gl_points : int
val gl_lines : int
val gl_line_loop : int
val gl_line_strip : int
val gl_triangles : int
val gl_triangle_strip : int
val gl_triangle_fan : int
val gl_quads : int
val gl_quad_strip : int
val gl_polygon : int
val gl_zero : int
val gl_one : int
val gl_src_color : int
val gl_one_minus_src_color : int
val gl_src_alpha : int
val gl_one_minus_src_alpha : int
val gl_dst_alpha : int
val gl_one_minus_dst_alpha : int
val gl_dst_color : int
val gl_one_minus_dst_color : int
val gl_src_alpha_saturate : int
val gl_true : int
val gl_false : int
val gl_clip_plane0 : int
val gl_clip_plane1 : int
val gl_clip_plane2 : int
val gl_clip_plane3 : int
val gl_clip_plane4 : int
val gl_clip_plane5 : int
val gl_byte : int
val gl_unsigned_byte : int
val gl_short : int
val gl_unsigned_short : int
val gl_int : int
val gl_unsigned_int : int
val gl_float : int
val gl_2_bytes : int
val gl_3_bytes : int
val gl_4_bytes : int
val gl_double : int
val gl_none : int
val gl_front_left : int
val gl_front_right : int
val gl_back_left : int
val gl_back_right : int
val gl_front : int
val gl_back : int
val gl_left : int
val gl_right : int
val gl_front_and_back : int
val gl_aux0 : int
val gl_aux1 : int
val gl_aux2 : int
val gl_aux3 : int
val gl_no_error : int
val gl_invalid_enum : int
val gl_invalid_value : int
val gl_invalid_operation : int
val gl_stack_overflow : int
val gl_stack_underflow : int
val gl_out_of_memory : int
val gl_2d : int
val gl_3d : int
val gl_3d_color : int
val gl_3d_color_texture : int
val gl_4d_color_texture : int
val gl_pass_through_token : int
val gl_point_token : int
val gl_line_token : int
val gl_polygon_token : int
val gl_bitmap_token : int
val gl_draw_pixel_token : int
val gl_copy_pixel_token : int
val gl_line_reset_token : int
val gl_exp : int
val gl_exp2 : int
val gl_cw : int
val gl_ccw : int
val gl_coeff : int
val gl_order : int
val gl_domain : int
val gl_current_color : int
val gl_current_index : int
val gl_current_normal : int
val gl_current_texture_coords : int
val gl_current_raster_color : int
val gl_current_raster_index : int
val gl_current_raster_texture_coords : int
val gl_current_raster_position : int
val gl_current_raster_position_valid : int
val gl_current_raster_distance : int
val gl_point_smooth : int
val gl_point_size : int
val gl_point_size_range : int
val gl_point_size_granularity : int
val gl_line_smooth : int
val gl_line_width : int
val gl_line_width_range : int
val gl_line_width_granularity : int
val gl_line_stipple : int
val gl_line_stipple_pattern : int
val gl_line_stipple_repeat : int
val gl_list_mode : int
val gl_max_list_nesting : int
val gl_list_base : int
val gl_list_index : int
val gl_polygon_mode : int
val gl_polygon_smooth : int
val gl_polygon_stipple : int
val gl_edge_flag : int
val gl_cull_face : int
val gl_cull_face_mode : int
val gl_front_face : int
val gl_lighting : int
val gl_light_model_local_viewer : int
val gl_light_model_two_side : int
val gl_light_model_ambient : int
val gl_shade_model : int
val gl_color_material_face : int
val gl_color_material_parameter : int
val gl_color_material : int
val gl_fog : int
val gl_fog_index : int
val gl_fog_density : int
val gl_fog_start : int
val gl_fog_end : int
val gl_fog_mode : int
val gl_fog_color : int
val gl_depth_range : int
val gl_depth_test : int
val gl_depth_writemask : int
val gl_depth_clear_value : int
val gl_depth_func : int
val gl_accum_clear_value : int
val gl_stencil_test : int
val gl_stencil_clear_value : int
val gl_stencil_func : int
val gl_stencil_value_mask : int
val gl_stencil_fail : int
val gl_stencil_pass_depth_fail : int
val gl_stencil_pass_depth_pass : int
val gl_stencil_ref : int
val gl_stencil_writemask : int
val gl_matrix_mode : int
val gl_normalize : int
val gl_viewport : int
val gl_modelview_stack_depth : int
val gl_projection_stack_depth : int
val gl_texture_stack_depth : int
val gl_modelview_matrix : int
val gl_projection_matrix : int
val gl_texture_matrix : int
val gl_attrib_stack_depth : int
val gl_client_attrib_stack_depth : int
val gl_alpha_test : int
val gl_alpha_test_func : int
val gl_alpha_test_ref : int
val gl_dither : int
val gl_blend_dst : int
val gl_blend_src : int
val gl_blend : int
val gl_logic_op_mode : int
val gl_index_logic_op : int
val gl_color_logic_op : int
val gl_aux_buffers : int
val gl_draw_buffer : int
val gl_read_buffer : int
val gl_scissor_box : int
val gl_scissor_test : int
val gl_index_clear_value : int
val gl_index_writemask : int
val gl_color_clear_value : int
val gl_color_writemask : int
val gl_index_mode : int
val gl_rgba_mode : int
val gl_doublebuffer : int
val gl_stereo : int
val gl_render_mode : int
val gl_perspective_correction_hint : int
val gl_point_smooth_hint : int
val gl_line_smooth_hint : int
val gl_polygon_smooth_hint : int
val gl_fog_hint : int
val gl_texture_gen_s : int
val gl_texture_gen_t : int
val gl_texture_gen_r : int
val gl_texture_gen_q : int
val gl_pixel_map_i_to_i : int
val gl_pixel_map_s_to_s : int
val gl_pixel_map_i_to_r : int
val gl_pixel_map_i_to_g : int
val gl_pixel_map_i_to_b : int
val gl_pixel_map_i_to_a : int
val gl_pixel_map_r_to_r : int
val gl_pixel_map_g_to_g : int
val gl_pixel_map_b_to_b : int
val gl_pixel_map_a_to_a : int
val gl_pixel_map_i_to_i_size : int
val gl_pixel_map_s_to_s_size : int
val gl_pixel_map_i_to_r_size : int
val gl_pixel_map_i_to_g_size : int
val gl_pixel_map_i_to_b_size : int
val gl_pixel_map_i_to_a_size : int
val gl_pixel_map_r_to_r_size : int
val gl_pixel_map_g_to_g_size : int
val gl_pixel_map_b_to_b_size : int
val gl_pixel_map_a_to_a_size : int
val gl_unpack_swap_bytes : int
val gl_unpack_lsb_first : int
val gl_unpack_row_length : int
val gl_unpack_skip_rows : int
val gl_unpack_skip_pixels : int
val gl_unpack_alignment : int
val gl_pack_swap_bytes : int
val gl_pack_lsb_first : int
val gl_pack_row_length : int
val gl_pack_skip_rows : int
val gl_pack_skip_pixels : int
val gl_pack_alignment : int
val gl_map_color : int
val gl_map_stencil : int
val gl_index_shift : int
val gl_index_offset : int
val gl_red_scale : int
val gl_red_bias : int
val gl_zoom_x : int
val gl_zoom_y : int
val gl_green_scale : int
val gl_green_bias : int
val gl_blue_scale : int
val gl_blue_bias : int
val gl_alpha_scale : int
val gl_alpha_bias : int
val gl_depth_scale : int
val gl_depth_bias : int
val gl_max_eval_order : int
val gl_max_lights : int
val gl_max_clip_planes : int
val gl_max_texture_size : int
val gl_max_pixel_map_table : int
val gl_max_attrib_stack_depth : int
val gl_max_modelview_stack_depth : int
val gl_max_name_stack_depth : int
val gl_max_projection_stack_depth : int
val gl_max_texture_stack_depth : int
val gl_max_viewport_dims : int
val gl_max_client_attrib_stack_depth : int
val gl_subpixel_bits : int
val gl_index_bits : int
val gl_red_bits : int
val gl_green_bits : int
val gl_blue_bits : int
val gl_alpha_bits : int
val gl_depth_bits : int
val gl_stencil_bits : int
val gl_accum_red_bits : int
val gl_accum_green_bits : int
val gl_accum_blue_bits : int
val gl_accum_alpha_bits : int
val gl_name_stack_depth : int
val gl_auto_normal : int
val gl_map1_color_4 : int
val gl_map1_index : int
val gl_map1_normal : int
val gl_map1_texture_coord_1 : int
val gl_map1_texture_coord_2 : int
val gl_map1_texture_coord_3 : int
val gl_map1_texture_coord_4 : int
val gl_map1_vertex_3 : int
val gl_map1_vertex_4 : int
val gl_map2_color_4 : int
val gl_map2_index : int
val gl_map2_normal : int
val gl_map2_texture_coord_1 : int
val gl_map2_texture_coord_2 : int
val gl_map2_texture_coord_3 : int
val gl_map2_texture_coord_4 : int
val gl_map2_vertex_3 : int
val gl_map2_vertex_4 : int
val gl_map1_grid_domain : int
val gl_map1_grid_segments : int
val gl_map2_grid_domain : int
val gl_map2_grid_segments : int
val gl_texture_1d : int
val gl_texture_2d : int
val gl_feedback_buffer_pointer : int
val gl_feedback_buffer_size : int
val gl_feedback_buffer_type : int
val gl_selection_buffer_pointer : int
val gl_selection_buffer_size : int
val gl_texture_width : int
val gl_texture_height : int
val gl_texture_internal_format : int
val gl_texture_border_color : int
val gl_texture_border : int
val gl_dont_care : int
val gl_fastest : int
val gl_nicest : int
val gl_light0 : int
val gl_light1 : int
val gl_light2 : int
val gl_light3 : int
val gl_light4 : int
val gl_light5 : int
val gl_light6 : int
val gl_light7 : int
val gl_ambient : int
val gl_diffuse : int
val gl_specular : int
val gl_position : int
val gl_spot_direction : int
val gl_spot_exponent : int
val gl_spot_cutoff : int
val gl_constant_attenuation : int
val gl_linear_attenuation : int
val gl_quadratic_attenuation : int
val gl_compile : int
val gl_compile_and_execute : int
val gl_clear : int
val gl_and : int
val gl_and_reverse : int
val gl_copy : int
val gl_and_inverted : int
val gl_noop : int
val gl_xor : int
val gl_or : int
val gl_nor : int
val gl_equiv : int
val gl_invert : int
val gl_or_reverse : int
val gl_copy_inverted : int
val gl_or_inverted : int
val gl_nand : int
val gl_set : int
val gl_emission : int
val gl_shininess : int
val gl_ambient_and_diffuse : int
val gl_color_indexes : int
val gl_modelview : int
val gl_projection : int
val gl_texture : int
val gl_color : int
val gl_depth : int
val gl_stencil : int
val gl_color_index : int
val gl_stencil_index : int
val gl_depth_component : int
val gl_red : int
val gl_green : int
val gl_blue : int
val gl_alpha : int
val gl_rgb : int
val gl_rgba : int
val gl_luminance : int
val gl_luminance_alpha : int
val gl_bitmap : int
val gl_point : int
val gl_line : int
val gl_fill : int
val gl_render : int
val gl_feedback : int
val gl_select : int
val gl_flat : int
val gl_smooth : int
val gl_keep : int
val gl_replace : int
val gl_incr : int
val gl_decr : int
val gl_vendor : int
val gl_renderer : int
val gl_version : int
val gl_extensions : int
val gl_s : int
val gl_t : int
val gl_r : int
val gl_q : int
val gl_modulate : int
val gl_decal : int
val gl_texture_env_mode : int
val gl_texture_env_color : int
val gl_texture_env : int
val gl_eye_linear : int
val gl_object_linear : int
val gl_sphere_map : int
val gl_texture_gen_mode : int
val gl_object_plane : int
val gl_eye_plane : int
val gl_nearest : int
val gl_linear : int
val gl_nearest_mipmap_nearest : int
val gl_linear_mipmap_nearest : int
val gl_nearest_mipmap_linear : int
val gl_linear_mipmap_linear : int
val gl_texture_mag_filter : int
val gl_texture_min_filter : int
val gl_texture_wrap_s : int
val gl_texture_wrap_t : int
val gl_clamp : int
val gl_repeat : int
val gl_client_pixel_store_bit : int
val gl_client_vertex_array_bit : int
val gl_client_all_attrib_bits : int
val gl_polygon_offset_factor : int
val gl_polygon_offset_units : int
val gl_polygon_offset_point : int
val gl_polygon_offset_line : int
val gl_polygon_offset_fill : int
val gl_alpha4 : int
val gl_alpha8 : int
val gl_alpha12 : int
val gl_alpha16 : int
val gl_luminance4 : int
val gl_luminance8 : int
val gl_luminance12 : int
val gl_luminance16 : int
val gl_luminance4_alpha4 : int
val gl_luminance6_alpha2 : int
val gl_luminance8_alpha8 : int
val gl_luminance12_alpha4 : int
val gl_luminance12_alpha12 : int
val gl_luminance16_alpha16 : int
val gl_intensity : int
val gl_intensity4 : int
val gl_intensity8 : int
val gl_intensity12 : int
val gl_intensity16 : int
val gl_r3_g3_b2 : int
val gl_rgb4 : int
val gl_rgb5 : int
val gl_rgb8 : int
val gl_rgb10 : int
val gl_rgb12 : int
val gl_rgb16 : int
val gl_rgba2 : int
val gl_rgba4 : int
val gl_rgb5_a1 : int
val gl_rgba8 : int
val gl_rgb10_a2 : int
val gl_rgba12 : int
val gl_rgba16 : int
val gl_texture_red_size : int
val gl_texture_green_size : int
val gl_texture_blue_size : int
val gl_texture_alpha_size : int
val gl_texture_luminance_size : int
val gl_texture_intensity_size : int
val gl_proxy_texture_1d : int
val gl_proxy_texture_2d : int
val gl_texture_priority : int
val gl_texture_resident : int
val gl_texture_binding_1d : int
val gl_texture_binding_2d : int
val gl_vertex_array : int
val gl_normal_array : int
val gl_color_array : int
val gl_index_array : int
val gl_texture_coord_array : int
val gl_edge_flag_array : int
val gl_vertex_array_size : int
val gl_vertex_array_type : int
val gl_vertex_array_stride : int
val gl_normal_array_type : int
val gl_normal_array_stride : int
val gl_color_array_size : int
val gl_color_array_type : int
val gl_color_array_stride : int
val gl_index_array_type : int
val gl_index_array_stride : int
val gl_texture_coord_array_size : int
val gl_texture_coord_array_type : int
val gl_texture_coord_array_stride : int
val gl_edge_flag_array_stride : int
val gl_vertex_array_pointer : int
val gl_normal_array_pointer : int
val gl_color_array_pointer : int
val gl_index_array_pointer : int
val gl_texture_coord_array_pointer : int
val gl_edge_flag_array_pointer : int
val gl_v2f : int
val gl_v3f : int
val gl_c4ub_v2f : int
val gl_c4ub_v3f : int
val gl_c3f_v3f : int
val gl_n3f_v3f : int
val gl_c4f_n3f_v3f : int
val gl_t2f_v3f : int
val gl_t4f_v4f : int
val gl_t2f_c4ub_v3f : int
val gl_t2f_c3f_v3f : int
val gl_t2f_n3f_v3f : int
val gl_t2f_c4f_n3f_v3f : int
val gl_t4f_c4f_n3f_v4f : int
val gl_logic_op : int
val gl_texture_components : int
val gl_color_index1_ext : int
val gl_color_index2_ext : int
val gl_color_index4_ext : int
val gl_color_index8_ext : int
val gl_color_index12_ext : int
val gl_color_index16_ext : int
val gl_unsigned_byte_3_3_2 : int
val gl_unsigned_short_4_4_4_4 : int
val gl_unsigned_short_5_5_5_1 : int
val gl_unsigned_int_8_8_8_8 : int
val gl_unsigned_int_10_10_10_2 : int
val gl_rescale_normal : int
val gl_unsigned_byte_2_3_3_rev : int
val gl_unsigned_short_5_6_5 : int
val gl_unsigned_short_5_6_5_rev : int
val gl_unsigned_short_4_4_4_4_rev : int
val gl_unsigned_short_1_5_5_5_rev : int
val gl_unsigned_int_8_8_8_8_rev : int
val gl_unsigned_int_2_10_10_10_rev : int
val gl_bgr : int
val gl_bgra : int
val gl_max_elements_vertices : int
val gl_max_elements_indices : int
val gl_clamp_to_edge : int
val gl_texture_min_lod : int
val gl_texture_max_lod : int
val gl_texture_base_level : int
val gl_texture_max_level : int
val gl_light_model_color_control : int
val gl_single_color : int
val gl_separate_specular_color : int
val gl_smooth_point_size_range : int
val gl_smooth_point_size_granularity : int
val gl_smooth_line_width_range : int
val gl_smooth_line_width_granularity : int
val gl_aliased_point_size_range : int
val gl_aliased_line_width_range : int
val gl_pack_skip_images : int
val gl_pack_image_height : int
val gl_unpack_skip_images : int
val gl_unpack_image_height : int
val gl_texture_3d : int
val gl_proxy_texture_3d : int
val gl_texture_depth : int
val gl_texture_wrap_r : int
val gl_max_3d_texture_size : int
val gl_texture_binding_3d : int
val gl_texture0 : int
val gl_texture1 : int
val gl_texture2 : int
val gl_texture3 : int
val gl_texture4 : int
val gl_texture5 : int
val gl_texture6 : int
val gl_texture7 : int
val gl_texture8 : int
val gl_texture9 : int
val gl_texture10 : int
val gl_texture11 : int
val gl_texture12 : int
val gl_texture13 : int
val gl_texture14 : int
val gl_texture15 : int
val gl_texture16 : int
val gl_texture17 : int
val gl_texture18 : int
val gl_texture19 : int
val gl_texture20 : int
val gl_texture21 : int
val gl_texture22 : int
val gl_texture23 : int
val gl_texture24 : int
val gl_texture25 : int
val gl_texture26 : int
val gl_texture27 : int
val gl_texture28 : int
val gl_texture29 : int
val gl_texture30 : int
val gl_texture31 : int
val gl_active_texture : int
val gl_client_active_texture : int
val gl_max_texture_units : int
val gl_normal_map : int
val gl_reflection_map : int
val gl_texture_cube_map : int
val gl_texture_binding_cube_map : int
val gl_texture_cube_map_positive_x : int
val gl_texture_cube_map_negative_x : int
val gl_texture_cube_map_positive_y : int
val gl_texture_cube_map_negative_y : int
val gl_texture_cube_map_positive_z : int
val gl_texture_cube_map_negative_z : int
val gl_proxy_texture_cube_map : int
val gl_max_cube_map_texture_size : int
val gl_compressed_alpha : int
val gl_compressed_luminance : int
val gl_compressed_luminance_alpha : int
val gl_compressed_intensity : int
val gl_compressed_rgb : int
val gl_compressed_rgba : int
val gl_texture_compression_hint : int
val gl_texture_compressed_image_size : int
val gl_texture_compressed : int
val gl_num_compressed_texture_formats : int
val gl_compressed_texture_formats : int
val gl_multisample : int
val gl_sample_alpha_to_coverage : int
val gl_sample_alpha_to_one : int
val gl_sample_coverage : int
val gl_sample_buffers : int
val gl_samples : int
val gl_sample_coverage_value : int
val gl_sample_coverage_invert : int
val gl_multisample_bit : int
val gl_transpose_modelview_matrix : int
val gl_transpose_projection_matrix : int
val gl_transpose_texture_matrix : int
val gl_transpose_color_matrix : int
val gl_combine : int
val gl_combine_rgb : int
val gl_combine_alpha : int
val gl_source0_rgb : int
val gl_source1_rgb : int
val gl_source2_rgb : int
val gl_source0_alpha : int
val gl_source1_alpha : int
val gl_source2_alpha : int
val gl_operand0_rgb : int
val gl_operand1_rgb : int
val gl_operand2_rgb : int
val gl_operand0_alpha : int
val gl_operand1_alpha : int
val gl_operand2_alpha : int
val gl_rgb_scale : int
val gl_add_signed : int
val gl_interpolate : int
val gl_subtract : int
val gl_constant : int
val gl_primary_color : int
val gl_previous : int
val gl_dot3_rgb : int
val gl_dot3_rgba : int
val gl_clamp_to_border : int
val gl_generate_mipmap : int
val gl_generate_mipmap_hint : int
val gl_depth_component16 : int
val gl_depth_component24 : int
val gl_depth_component32 : int
val gl_texture_depth_size : int
val gl_depth_texture_mode : int
val gl_texture_compare_mode : int
val gl_texture_compare_func : int
val gl_compare_r_to_texture : int
val gl_fog_coordinate_source : int
val gl_fog_coordinate : int
val gl_fragment_depth : int
val gl_current_fog_coordinate : int
val gl_fog_coordinate_array_type : int
val gl_fog_coordinate_array_stride : int
val gl_fog_coordinate_array_pointer : int
val gl_fog_coordinate_array : int
val gl_point_size_min : int
val gl_point_size_max : int
val gl_point_fade_threshold_size : int
val gl_point_distance_attenuation : int
val gl_color_sum : int
val gl_current_secondary_color : int
val gl_secondary_color_array_size : int
val gl_secondary_color_array_type : int
val gl_secondary_color_array_stride : int
val gl_secondary_color_array_pointer : int
val gl_secondary_color_array : int
val gl_blend_dst_rgb : int
val gl_blend_src_rgb : int
val gl_blend_dst_alpha : int
val gl_blend_src_alpha : int
val gl_incr_wrap : int
val gl_decr_wrap : int
val gl_texture_filter_control : int
val gl_texture_lod_bias : int
val gl_max_texture_lod_bias : int
val gl_mirrored_repeat : int
val gl_buffer_size : int
val gl_buffer_usage : int
val gl_query_counter_bits : int
val gl_current_query : int
val gl_query_result : int
val gl_query_result_available : int
val gl_array_buffer : int
val gl_element_array_buffer : int
val gl_array_buffer_binding : int
val gl_element_array_buffer_binding : int
val gl_vertex_array_buffer_binding : int
val gl_normal_array_buffer_binding : int
val gl_color_array_buffer_binding : int
val gl_index_array_buffer_binding : int
val gl_texture_coord_array_buffer_binding : int
val gl_edge_flag_array_buffer_binding : int
val gl_secondary_color_array_buffer_binding : int
val gl_fog_coordinate_array_buffer_binding : int
val gl_weight_array_buffer_binding : int
val gl_vertex_attrib_array_buffer_binding : int
val gl_read_only : int
val gl_write_only : int
val gl_read_write : int
val gl_buffer_access : int
val gl_buffer_mapped : int
val gl_buffer_map_pointer : int
val gl_stream_draw : int
val gl_stream_read : int
val gl_stream_copy : int
val gl_static_draw : int
val gl_static_read : int
val gl_static_copy : int
val gl_dynamic_draw : int
val gl_dynamic_read : int
val gl_dynamic_copy : int
val gl_samples_passed : int
val gl_fog_coord_src : int
val gl_fog_coord : int
val gl_current_fog_coord : int
val gl_fog_coord_array_type : int
val gl_fog_coord_array_stride : int
val gl_fog_coord_array_pointer : int
val gl_fog_coord_array : int
val gl_fog_coord_array_buffer_binding : int
val gl_src0_rgb : int
val gl_src1_rgb : int
val gl_src2_rgb : int
val gl_src0_alpha : int
val gl_src1_alpha : int
val gl_src2_alpha : int
val gl_blend_equation_rgb : int
val gl_vertex_attrib_array_enabled : int
val gl_vertex_attrib_array_size : int
val gl_vertex_attrib_array_stride : int
val gl_vertex_attrib_array_type : int
val gl_current_vertex_attrib : int
val gl_vertex_program_point_size : int
val gl_vertex_program_two_side : int
val gl_vertex_attrib_array_pointer : int
val gl_stencil_back_func : int
val gl_stencil_back_fail : int
val gl_stencil_back_pass_depth_fail : int
val gl_stencil_back_pass_depth_pass : int
val gl_max_draw_buffers : int
val gl_draw_buffer0 : int
val gl_draw_buffer1 : int
val gl_draw_buffer2 : int
val gl_draw_buffer3 : int
val gl_draw_buffer4 : int
val gl_draw_buffer5 : int
val gl_draw_buffer6 : int
val gl_draw_buffer7 : int
val gl_draw_buffer8 : int
val gl_draw_buffer9 : int
val gl_draw_buffer10 : int
val gl_draw_buffer11 : int
val gl_draw_buffer12 : int
val gl_draw_buffer13 : int
val gl_draw_buffer14 : int
val gl_draw_buffer15 : int
val gl_blend_equation_alpha : int
val gl_point_sprite : int
val gl_coord_replace : int
val gl_max_vertex_attribs : int
val gl_vertex_attrib_array_normalized : int
val gl_max_texture_coords : int
val gl_max_texture_image_units : int
val gl_fragment_shader : int
val gl_vertex_shader : int
val gl_max_fragment_uniform_components : int
val gl_max_vertex_uniform_components : int
val gl_max_varying_floats : int
val gl_max_vertex_texture_image_units : int
val gl_max_combined_texture_image_units : int
val gl_shader_type : int
val gl_float_vec2 : int
val gl_float_vec3 : int
val gl_float_vec4 : int
val gl_int_vec2 : int
val gl_int_vec3 : int
val gl_int_vec4 : int
val gl_bool : int
val gl_bool_vec2 : int
val gl_bool_vec3 : int
val gl_bool_vec4 : int
val gl_float_mat2 : int
val gl_float_mat3 : int
val gl_float_mat4 : int
val gl_sampler_1d : int
val gl_sampler_2d : int
val gl_sampler_3d : int
val gl_sampler_cube : int
val gl_sampler_1d_shadow : int
val gl_sampler_2d_shadow : int
val gl_delete_status : int
val gl_compile_status : int
val gl_link_status : int
val gl_validate_status : int
val gl_info_log_length : int
val gl_attached_shaders : int
val gl_active_uniforms : int
val gl_active_uniform_max_length : int
val gl_shader_source_length : int
val gl_active_attributes : int
val gl_active_attribute_max_length : int
val gl_fragment_shader_derivative_hint : int
val gl_shading_language_version : int
val gl_current_program : int
val gl_point_sprite_coord_origin : int
val gl_lower_left : int
val gl_upper_left : int
val gl_stencil_back_ref : int
val gl_stencil_back_value_mask : int
val gl_stencil_back_writemask : int
val gl_current_raster_secondary_color : int
val gl_pixel_pack_buffer : int
val gl_pixel_unpack_buffer : int
val gl_pixel_pack_buffer_binding : int
val gl_pixel_unpack_buffer_binding : int
val gl_srgb : int
val gl_srgb8 : int
val gl_srgb_alpha : int
val gl_srgb8_alpha8 : int
val gl_sluminance_alpha : int
val gl_sluminance8_alpha8 : int
val gl_sluminance : int
val gl_sluminance8 : int
val gl_compressed_srgb : int
val gl_compressed_srgb_alpha : int
val gl_compressed_sluminance : int
val gl_compressed_sluminance_alpha : int
external glAccum : int -> float -> unit = "glstub_glAccum" "glstub_glAccum"
external glActiveStencilFaceEXT : int -> unit
  = "glstub_glActiveStencilFaceEXT" "glstub_glActiveStencilFaceEXT"
external glActiveTexture : int -> unit = "glstub_glActiveTexture"
  "glstub_glActiveTexture"
external glActiveTextureARB : int -> unit = "glstub_glActiveTextureARB"
  "glstub_glActiveTextureARB"
external glActiveVaryingNV : int -> string -> unit
  = "glstub_glActiveVaryingNV" "glstub_glActiveVaryingNV"
external glAddSwapHintRectWIN : int -> int -> int -> int -> unit
  = "glstub_glAddSwapHintRectWIN" "glstub_glAddSwapHintRectWIN"
external glAlphaFragmentOp1ATI :
  int -> int -> int -> int -> int -> int -> unit
  = "glstub_glAlphaFragmentOp1ATI_byte" "glstub_glAlphaFragmentOp1ATI"
external glAlphaFragmentOp2ATI :
  int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glAlphaFragmentOp2ATI_byte" "glstub_glAlphaFragmentOp2ATI"
external glAlphaFragmentOp3ATI :
  int ->
  int ->
  int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glAlphaFragmentOp3ATI_byte" "glstub_glAlphaFragmentOp3ATI"
external glAlphaFunc : int -> float -> unit = "glstub_glAlphaFunc"
  "glstub_glAlphaFunc"
external glApplyTextureEXT : int -> unit = "glstub_glApplyTextureEXT"
  "glstub_glApplyTextureEXT"
val glAreProgramsResidentNV : int -> int array -> bool array -> bool
val glAreTexturesResident : int -> int array -> bool array -> bool
val glAreTexturesResidentEXT : int -> int array -> bool array -> bool
external glArrayElement : int -> unit = "glstub_glArrayElement"
  "glstub_glArrayElement"
external glArrayElementEXT : int -> unit = "glstub_glArrayElementEXT"
  "glstub_glArrayElementEXT"
external glArrayObjectATI : int -> int -> int -> int -> int -> int -> unit
  = "glstub_glArrayObjectATI_byte" "glstub_glArrayObjectATI"
external glAsyncMarkerSGIX : int -> unit = "glstub_glAsyncMarkerSGIX"
  "glstub_glAsyncMarkerSGIX"
external glAttachObjectARB : int -> int -> unit = "glstub_glAttachObjectARB"
  "glstub_glAttachObjectARB"
external glAttachShader : int -> int -> unit = "glstub_glAttachShader"
  "glstub_glAttachShader"
external glBegin : int -> unit = "glstub_glBegin" "glstub_glBegin"
external glBeginFragmentShaderATI : unit -> unit
  = "glstub_glBeginFragmentShaderATI" "glstub_glBeginFragmentShaderATI"
external glBeginOcclusionQueryNV : int -> unit
  = "glstub_glBeginOcclusionQueryNV" "glstub_glBeginOcclusionQueryNV"
external glBeginQuery : int -> int -> unit = "glstub_glBeginQuery"
  "glstub_glBeginQuery"
external glBeginQueryARB : int -> int -> unit = "glstub_glBeginQueryARB"
  "glstub_glBeginQueryARB"
external glBeginSceneEXT : unit -> unit = "glstub_glBeginSceneEXT"
  "glstub_glBeginSceneEXT"
external glBeginTransformFeedbackNV : int -> unit
  = "glstub_glBeginTransformFeedbackNV" "glstub_glBeginTransformFeedbackNV"
external glBeginVertexShaderEXT : unit -> unit
  = "glstub_glBeginVertexShaderEXT" "glstub_glBeginVertexShaderEXT"
external glBindAttribLocation : int -> int -> string -> unit
  = "glstub_glBindAttribLocation" "glstub_glBindAttribLocation"
external glBindAttribLocationARB : int -> int -> string -> unit
  = "glstub_glBindAttribLocationARB" "glstub_glBindAttribLocationARB"
external glBindBuffer : int -> int -> unit = "glstub_glBindBuffer"
  "glstub_glBindBuffer"
external glBindBufferARB : int -> int -> unit = "glstub_glBindBufferARB"
  "glstub_glBindBufferARB"
external glBindBufferBaseNV : int -> int -> int -> unit
  = "glstub_glBindBufferBaseNV" "glstub_glBindBufferBaseNV"
external glBindBufferOffsetNV : int -> int -> int -> int -> unit
  = "glstub_glBindBufferOffsetNV" "glstub_glBindBufferOffsetNV"
external glBindBufferRangeNV : int -> int -> int -> int -> int -> unit
  = "glstub_glBindBufferRangeNV" "glstub_glBindBufferRangeNV"
external glBindFragDataLocationEXT : int -> int -> string -> unit
  = "glstub_glBindFragDataLocationEXT" "glstub_glBindFragDataLocationEXT"
external glBindFragmentShaderATI : int -> unit
  = "glstub_glBindFragmentShaderATI" "glstub_glBindFragmentShaderATI"
external glBindFramebufferEXT : int -> int -> unit
  = "glstub_glBindFramebufferEXT" "glstub_glBindFramebufferEXT"
external glBindLightParameterEXT : int -> int -> int
  = "glstub_glBindLightParameterEXT" "glstub_glBindLightParameterEXT"
external glBindMaterialParameterEXT : int -> int -> int
  = "glstub_glBindMaterialParameterEXT" "glstub_glBindMaterialParameterEXT"
external glBindParameterEXT : int -> int = "glstub_glBindParameterEXT"
  "glstub_glBindParameterEXT"
external glBindProgramARB : int -> int -> unit = "glstub_glBindProgramARB"
  "glstub_glBindProgramARB"
external glBindProgramNV : int -> int -> unit = "glstub_glBindProgramNV"
  "glstub_glBindProgramNV"
external glBindRenderbufferEXT : int -> int -> unit
  = "glstub_glBindRenderbufferEXT" "glstub_glBindRenderbufferEXT"
external glBindTexGenParameterEXT : int -> int -> int -> int
  = "glstub_glBindTexGenParameterEXT" "glstub_glBindTexGenParameterEXT"
external glBindTexture : int -> int -> unit = "glstub_glBindTexture"
  "glstub_glBindTexture"
external glBindTextureEXT : int -> int -> unit = "glstub_glBindTextureEXT"
  "glstub_glBindTextureEXT"
external glBindTextureUnitParameterEXT : int -> int -> int
  = "glstub_glBindTextureUnitParameterEXT"
  "glstub_glBindTextureUnitParameterEXT"
external glBindVertexArrayAPPLE : int -> unit
  = "glstub_glBindVertexArrayAPPLE" "glstub_glBindVertexArrayAPPLE"
external glBindVertexShaderEXT : int -> unit = "glstub_glBindVertexShaderEXT"
  "glstub_glBindVertexShaderEXT"
external glBinormalPointerEXT : int -> int -> 'a -> unit
  = "glstub_glBinormalPointerEXT" "glstub_glBinormalPointerEXT"
val glBitmap :
  int -> int -> float -> float -> float -> float -> int array -> unit
external glBlendColor : float -> float -> float -> float -> unit
  = "glstub_glBlendColor" "glstub_glBlendColor"
external glBlendColorEXT : float -> float -> float -> float -> unit
  = "glstub_glBlendColorEXT" "glstub_glBlendColorEXT"
external glBlendEquation : int -> unit = "glstub_glBlendEquation"
  "glstub_glBlendEquation"
external glBlendEquationEXT : int -> unit = "glstub_glBlendEquationEXT"
  "glstub_glBlendEquationEXT"
external glBlendEquationSeparate : int -> int -> unit
  = "glstub_glBlendEquationSeparate" "glstub_glBlendEquationSeparate"
external glBlendEquationSeparateEXT : int -> int -> unit
  = "glstub_glBlendEquationSeparateEXT" "glstub_glBlendEquationSeparateEXT"
external glBlendFunc : int -> int -> unit = "glstub_glBlendFunc"
  "glstub_glBlendFunc"
external glBlendFuncSeparate : int -> int -> int -> int -> unit
  = "glstub_glBlendFuncSeparate" "glstub_glBlendFuncSeparate"
external glBlendFuncSeparateEXT : int -> int -> int -> int -> unit
  = "glstub_glBlendFuncSeparateEXT" "glstub_glBlendFuncSeparateEXT"
external glBlitFramebufferEXT :
  int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glBlitFramebufferEXT_byte" "glstub_glBlitFramebufferEXT"
external glBufferData : int -> int -> 'a -> int -> unit
  = "glstub_glBufferData" "glstub_glBufferData"
external glBufferDataARB : int -> int -> 'a -> int -> unit
  = "glstub_glBufferDataARB" "glstub_glBufferDataARB"
external glBufferRegionEnabledEXT : unit -> int
  = "glstub_glBufferRegionEnabledEXT" "glstub_glBufferRegionEnabledEXT"
external glBufferSubData : int -> int -> int -> 'a -> unit
  = "glstub_glBufferSubData" "glstub_glBufferSubData"
external glBufferSubDataARB : int -> int -> int -> 'a -> unit
  = "glstub_glBufferSubDataARB" "glstub_glBufferSubDataARB"
external glCallList : int -> unit = "glstub_glCallList" "glstub_glCallList"
external glCallLists : int -> int -> 'a -> unit = "glstub_glCallLists"
  "glstub_glCallLists"
external glCheckFramebufferStatusEXT : int -> int
  = "glstub_glCheckFramebufferStatusEXT" "glstub_glCheckFramebufferStatusEXT"
external glClampColorARB : int -> int -> unit = "glstub_glClampColorARB"
  "glstub_glClampColorARB"
external glClear : int -> unit = "glstub_glClear" "glstub_glClear"
external glClearAccum : float -> float -> float -> float -> unit
  = "glstub_glClearAccum" "glstub_glClearAccum"
external glClearColor : float -> float -> float -> float -> unit
  = "glstub_glClearColor" "glstub_glClearColor"
external glClearColorIiEXT : int -> int -> int -> int -> unit
  = "glstub_glClearColorIiEXT" "glstub_glClearColorIiEXT"
external glClearColorIuiEXT : int -> int -> int -> int -> unit
  = "glstub_glClearColorIuiEXT" "glstub_glClearColorIuiEXT"
external glClearDepth : float -> unit = "glstub_glClearDepth"
  "glstub_glClearDepth"
external glClearDepthdNV : float -> unit = "glstub_glClearDepthdNV"
  "glstub_glClearDepthdNV"
external glClearDepthfOES : float -> unit = "glstub_glClearDepthfOES"
  "glstub_glClearDepthfOES"
external glClearIndex : float -> unit = "glstub_glClearIndex"
  "glstub_glClearIndex"
external glClearStencil : int -> unit = "glstub_glClearStencil"
  "glstub_glClearStencil"
external glClientActiveTexture : int -> unit = "glstub_glClientActiveTexture"
  "glstub_glClientActiveTexture"
external glClientActiveTextureARB : int -> unit
  = "glstub_glClientActiveTextureARB" "glstub_glClientActiveTextureARB"
external glClientActiveVertexStreamATI : int -> unit
  = "glstub_glClientActiveVertexStreamATI"
  "glstub_glClientActiveVertexStreamATI"
external glClipPlane : int -> float array -> unit = "glstub_glClipPlane"
  "glstub_glClipPlane"
val glClipPlanefOES : int -> float array -> unit
external glColor3b : int -> int -> int -> unit = "glstub_glColor3b"
  "glstub_glColor3b"
val glColor3bv : int array -> unit
external glColor3d : float -> float -> float -> unit = "glstub_glColor3d"
  "glstub_glColor3d"
external glColor3dv : float array -> unit = "glstub_glColor3dv"
  "glstub_glColor3dv"
external glColor3f : float -> float -> float -> unit = "glstub_glColor3f"
  "glstub_glColor3f"
external glColor3fVertex3fSUN :
  float -> float -> float -> float -> float -> float -> unit
  = "glstub_glColor3fVertex3fSUN_byte" "glstub_glColor3fVertex3fSUN"
val glColor3fVertex3fvSUN : float array -> float array -> unit
val glColor3fv : float array -> unit
external glColor3hNV : int -> int -> int -> unit = "glstub_glColor3hNV"
  "glstub_glColor3hNV"
val glColor3hvNV : int array -> unit
external glColor3i : int -> int -> int -> unit = "glstub_glColor3i"
  "glstub_glColor3i"
val glColor3iv : int array -> unit
external glColor3s : int -> int -> int -> unit = "glstub_glColor3s"
  "glstub_glColor3s"
val glColor3sv : int array -> unit
external glColor3ub : int -> int -> int -> unit = "glstub_glColor3ub"
  "glstub_glColor3ub"
val glColor3ubv : int array -> unit
external glColor3ui : int -> int -> int -> unit = "glstub_glColor3ui"
  "glstub_glColor3ui"
val glColor3uiv : int array -> unit
external glColor3us : int -> int -> int -> unit = "glstub_glColor3us"
  "glstub_glColor3us"
val glColor3usv : int array -> unit
external glColor4b : int -> int -> int -> int -> unit = "glstub_glColor4b"
  "glstub_glColor4b"
val glColor4bv : int array -> unit
external glColor4d : float -> float -> float -> float -> unit
  = "glstub_glColor4d" "glstub_glColor4d"
external glColor4dv : float array -> unit = "glstub_glColor4dv"
  "glstub_glColor4dv"
external glColor4f : float -> float -> float -> float -> unit
  = "glstub_glColor4f" "glstub_glColor4f"
external glColor4fNormal3fVertex3fSUN :
  float ->
  float ->
  float ->
  float -> float -> float -> float -> float -> float -> float -> unit
  = "glstub_glColor4fNormal3fVertex3fSUN_byte"
  "glstub_glColor4fNormal3fVertex3fSUN"
val glColor4fNormal3fVertex3fvSUN :
  float array -> float array -> float array -> unit
val glColor4fv : float array -> unit
external glColor4hNV : int -> int -> int -> int -> unit
  = "glstub_glColor4hNV" "glstub_glColor4hNV"
val glColor4hvNV : int array -> unit
external glColor4i : int -> int -> int -> int -> unit = "glstub_glColor4i"
  "glstub_glColor4i"
val glColor4iv : int array -> unit
external glColor4s : int -> int -> int -> int -> unit = "glstub_glColor4s"
  "glstub_glColor4s"
val glColor4sv : int array -> unit
external glColor4ub : int -> int -> int -> int -> unit = "glstub_glColor4ub"
  "glstub_glColor4ub"
external glColor4ubVertex2fSUN :
  int -> int -> int -> int -> float -> float -> unit
  = "glstub_glColor4ubVertex2fSUN_byte" "glstub_glColor4ubVertex2fSUN"
val glColor4ubVertex2fvSUN : int array -> float array -> unit
external glColor4ubVertex3fSUN :
  int -> int -> int -> int -> float -> float -> float -> unit
  = "glstub_glColor4ubVertex3fSUN_byte" "glstub_glColor4ubVertex3fSUN"
val glColor4ubVertex3fvSUN : int array -> float array -> unit
val glColor4ubv : int array -> unit
external glColor4ui : int -> int -> int -> int -> unit = "glstub_glColor4ui"
  "glstub_glColor4ui"
val glColor4uiv : int array -> unit
external glColor4us : int -> int -> int -> int -> unit = "glstub_glColor4us"
  "glstub_glColor4us"
val glColor4usv : int array -> unit
external glColorFragmentOp1ATI :
  int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glColorFragmentOp1ATI_byte" "glstub_glColorFragmentOp1ATI"
external glColorFragmentOp2ATI :
  int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glColorFragmentOp2ATI_byte" "glstub_glColorFragmentOp2ATI"
external glColorFragmentOp3ATI :
  int ->
  int ->
  int ->
  int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glColorFragmentOp3ATI_byte" "glstub_glColorFragmentOp3ATI"
external glColorMask : bool -> bool -> bool -> bool -> unit
  = "glstub_glColorMask" "glstub_glColorMask"
external glColorMaskIndexedEXT : int -> bool -> bool -> bool -> bool -> unit
  = "glstub_glColorMaskIndexedEXT" "glstub_glColorMaskIndexedEXT"
external glColorMaterial : int -> int -> unit = "glstub_glColorMaterial"
  "glstub_glColorMaterial"
external glColorPointer : int -> int -> int -> 'a -> unit
  = "glstub_glColorPointer" "glstub_glColorPointer"
external glColorPointerEXT : int -> int -> int -> int -> 'a -> unit
  = "glstub_glColorPointerEXT" "glstub_glColorPointerEXT"
external glColorPointerListIBM : int -> int -> int -> 'a -> int -> unit
  = "glstub_glColorPointerListIBM" "glstub_glColorPointerListIBM"
external glColorPointervINTEL : int -> int -> 'a -> unit
  = "glstub_glColorPointervINTEL" "glstub_glColorPointervINTEL"
external glColorSubTable : int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glColorSubTable_byte" "glstub_glColorSubTable"
external glColorSubTableEXT : int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glColorSubTableEXT_byte" "glstub_glColorSubTableEXT"
external glColorTable : int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glColorTable_byte" "glstub_glColorTable"
external glColorTableEXT : int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glColorTableEXT_byte" "glstub_glColorTableEXT"
val glColorTableParameterfv : int -> int -> float array -> unit
val glColorTableParameterfvSGI : int -> int -> float array -> unit
val glColorTableParameteriv : int -> int -> int array -> unit
val glColorTableParameterivSGI : int -> int -> int array -> unit
external glColorTableSGI : int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glColorTableSGI_byte" "glstub_glColorTableSGI"
external glCombinerInputNV : int -> int -> int -> int -> int -> int -> unit
  = "glstub_glCombinerInputNV_byte" "glstub_glCombinerInputNV"
external glCombinerOutputNV :
  int ->
  int -> int -> int -> int -> int -> int -> bool -> bool -> bool -> unit
  = "glstub_glCombinerOutputNV_byte" "glstub_glCombinerOutputNV"
external glCombinerParameterfNV : int -> float -> unit
  = "glstub_glCombinerParameterfNV" "glstub_glCombinerParameterfNV"
val glCombinerParameterfvNV : int -> float array -> unit
external glCombinerParameteriNV : int -> int -> unit
  = "glstub_glCombinerParameteriNV" "glstub_glCombinerParameteriNV"
val glCombinerParameterivNV : int -> int array -> unit
val glCombinerStageParameterfvNV : int -> int -> float array -> unit
external glCompileShader : int -> unit = "glstub_glCompileShader"
  "glstub_glCompileShader"
external glCompileShaderARB : int -> unit = "glstub_glCompileShaderARB"
  "glstub_glCompileShaderARB"
external glCompressedTexImage1D :
  int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glCompressedTexImage1D_byte" "glstub_glCompressedTexImage1D"
external glCompressedTexImage1DARB :
  int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glCompressedTexImage1DARB_byte"
  "glstub_glCompressedTexImage1DARB"
external glCompressedTexImage2D :
  int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glCompressedTexImage2D_byte" "glstub_glCompressedTexImage2D"
external glCompressedTexImage2DARB :
  int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glCompressedTexImage2DARB_byte"
  "glstub_glCompressedTexImage2DARB"
external glCompressedTexImage3D :
  int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glCompressedTexImage3D_byte" "glstub_glCompressedTexImage3D"
external glCompressedTexImage3DARB :
  int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glCompressedTexImage3DARB_byte"
  "glstub_glCompressedTexImage3DARB"
external glCompressedTexSubImage1D :
  int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glCompressedTexSubImage1D_byte"
  "glstub_glCompressedTexSubImage1D"
external glCompressedTexSubImage1DARB :
  int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glCompressedTexSubImage1DARB_byte"
  "glstub_glCompressedTexSubImage1DARB"
external glCompressedTexSubImage2D :
  int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glCompressedTexSubImage2D_byte"
  "glstub_glCompressedTexSubImage2D"
external glCompressedTexSubImage2DARB :
  int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glCompressedTexSubImage2DARB_byte"
  "glstub_glCompressedTexSubImage2DARB"
external glCompressedTexSubImage3D :
  int ->
  int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glCompressedTexSubImage3D_byte"
  "glstub_glCompressedTexSubImage3D"
external glCompressedTexSubImage3DARB :
  int ->
  int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glCompressedTexSubImage3DARB_byte"
  "glstub_glCompressedTexSubImage3DARB"
external glConvolutionFilter1D :
  int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glConvolutionFilter1D_byte" "glstub_glConvolutionFilter1D"
external glConvolutionFilter1DEXT :
  int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glConvolutionFilter1DEXT_byte" "glstub_glConvolutionFilter1DEXT"
external glConvolutionFilter2D :
  int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glConvolutionFilter2D_byte" "glstub_glConvolutionFilter2D"
external glConvolutionFilter2DEXT :
  int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glConvolutionFilter2DEXT_byte" "glstub_glConvolutionFilter2DEXT"
external glConvolutionParameterf : int -> int -> float -> unit
  = "glstub_glConvolutionParameterf" "glstub_glConvolutionParameterf"
external glConvolutionParameterfEXT : int -> int -> float -> unit
  = "glstub_glConvolutionParameterfEXT" "glstub_glConvolutionParameterfEXT"
val glConvolutionParameterfv : int -> int -> float array -> unit
val glConvolutionParameterfvEXT : int -> int -> float array -> unit
external glConvolutionParameteri : int -> int -> int -> unit
  = "glstub_glConvolutionParameteri" "glstub_glConvolutionParameteri"
external glConvolutionParameteriEXT : int -> int -> int -> unit
  = "glstub_glConvolutionParameteriEXT" "glstub_glConvolutionParameteriEXT"
val glConvolutionParameteriv : int -> int -> int array -> unit
val glConvolutionParameterivEXT : int -> int -> int array -> unit
external glCopyColorSubTable : int -> int -> int -> int -> int -> unit
  = "glstub_glCopyColorSubTable" "glstub_glCopyColorSubTable"
external glCopyColorSubTableEXT : int -> int -> int -> int -> int -> unit
  = "glstub_glCopyColorSubTableEXT" "glstub_glCopyColorSubTableEXT"
external glCopyColorTable : int -> int -> int -> int -> int -> unit
  = "glstub_glCopyColorTable" "glstub_glCopyColorTable"
external glCopyColorTableSGI : int -> int -> int -> int -> int -> unit
  = "glstub_glCopyColorTableSGI" "glstub_glCopyColorTableSGI"
external glCopyConvolutionFilter1D : int -> int -> int -> int -> int -> unit
  = "glstub_glCopyConvolutionFilter1D" "glstub_glCopyConvolutionFilter1D"
external glCopyConvolutionFilter1DEXT :
  int -> int -> int -> int -> int -> unit
  = "glstub_glCopyConvolutionFilter1DEXT"
  "glstub_glCopyConvolutionFilter1DEXT"
external glCopyConvolutionFilter2D :
  int -> int -> int -> int -> int -> int -> unit
  = "glstub_glCopyConvolutionFilter2D_byte"
  "glstub_glCopyConvolutionFilter2D"
external glCopyConvolutionFilter2DEXT :
  int -> int -> int -> int -> int -> int -> unit
  = "glstub_glCopyConvolutionFilter2DEXT_byte"
  "glstub_glCopyConvolutionFilter2DEXT"
external glCopyPixels : int -> int -> int -> int -> int -> unit
  = "glstub_glCopyPixels" "glstub_glCopyPixels"
external glCopyTexImage1D :
  int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glCopyTexImage1D_byte" "glstub_glCopyTexImage1D"
external glCopyTexImage1DEXT :
  int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glCopyTexImage1DEXT_byte" "glstub_glCopyTexImage1DEXT"
external glCopyTexImage2D :
  int -> int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glCopyTexImage2D_byte" "glstub_glCopyTexImage2D"
external glCopyTexImage2DEXT :
  int -> int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glCopyTexImage2DEXT_byte" "glstub_glCopyTexImage2DEXT"
external glCopyTexSubImage1D : int -> int -> int -> int -> int -> int -> unit
  = "glstub_glCopyTexSubImage1D_byte" "glstub_glCopyTexSubImage1D"
external glCopyTexSubImage1DEXT :
  int -> int -> int -> int -> int -> int -> unit
  = "glstub_glCopyTexSubImage1DEXT_byte" "glstub_glCopyTexSubImage1DEXT"
external glCopyTexSubImage2D :
  int -> int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glCopyTexSubImage2D_byte" "glstub_glCopyTexSubImage2D"
external glCopyTexSubImage2DEXT :
  int -> int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glCopyTexSubImage2DEXT_byte" "glstub_glCopyTexSubImage2DEXT"
external glCopyTexSubImage3D :
  int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glCopyTexSubImage3D_byte" "glstub_glCopyTexSubImage3D"
external glCopyTexSubImage3DEXT :
  int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glCopyTexSubImage3DEXT_byte" "glstub_glCopyTexSubImage3DEXT"
external glCreateProgram : unit -> int = "glstub_glCreateProgram"
  "glstub_glCreateProgram"
external glCreateProgramObjectARB : unit -> int
  = "glstub_glCreateProgramObjectARB" "glstub_glCreateProgramObjectARB"
external glCreateShader : int -> int = "glstub_glCreateShader"
  "glstub_glCreateShader"
external glCreateShaderObjectARB : int -> int
  = "glstub_glCreateShaderObjectARB" "glstub_glCreateShaderObjectARB"
external glCullFace : int -> unit = "glstub_glCullFace" "glstub_glCullFace"
external glCullParameterdvEXT : int -> float array -> unit
  = "glstub_glCullParameterdvEXT" "glstub_glCullParameterdvEXT"
val glCullParameterfvEXT : int -> float array -> unit
external glCurrentPaletteMatrixARB : int -> unit
  = "glstub_glCurrentPaletteMatrixARB" "glstub_glCurrentPaletteMatrixARB"
external glDeleteAsyncMarkersSGIX : int -> int -> unit
  = "glstub_glDeleteAsyncMarkersSGIX" "glstub_glDeleteAsyncMarkersSGIX"
external glDeleteBufferRegionEXT : int -> unit
  = "glstub_glDeleteBufferRegionEXT" "glstub_glDeleteBufferRegionEXT"
val glDeleteBuffers : int -> int array -> unit
val glDeleteBuffersARB : int -> int array -> unit
val glDeleteFencesAPPLE : int -> int array -> unit
val glDeleteFencesNV : int -> int array -> unit
external glDeleteFragmentShaderATI : int -> unit
  = "glstub_glDeleteFragmentShaderATI" "glstub_glDeleteFragmentShaderATI"
val glDeleteFramebuffersEXT : int -> int array -> unit
external glDeleteLists : int -> int -> unit = "glstub_glDeleteLists"
  "glstub_glDeleteLists"
external glDeleteObjectARB : int -> unit = "glstub_glDeleteObjectARB"
  "glstub_glDeleteObjectARB"
val glDeleteOcclusionQueriesNV : int -> int array -> unit
external glDeleteProgram : int -> unit = "glstub_glDeleteProgram"
  "glstub_glDeleteProgram"
val glDeleteProgramsARB : int -> int array -> unit
val glDeleteProgramsNV : int -> int array -> unit
val glDeleteQueries : int -> int array -> unit
val glDeleteQueriesARB : int -> int array -> unit
val glDeleteRenderbuffersEXT : int -> int array -> unit
external glDeleteShader : int -> unit = "glstub_glDeleteShader"
  "glstub_glDeleteShader"
val glDeleteTextures : int -> int array -> unit
val glDeleteTexturesEXT : int -> int array -> unit
val glDeleteVertexArraysAPPLE : int -> int array -> unit
external glDeleteVertexShaderEXT : int -> unit
  = "glstub_glDeleteVertexShaderEXT" "glstub_glDeleteVertexShaderEXT"
external glDepthBoundsEXT : float -> float -> unit
  = "glstub_glDepthBoundsEXT" "glstub_glDepthBoundsEXT"
external glDepthBoundsdNV : float -> float -> unit
  = "glstub_glDepthBoundsdNV" "glstub_glDepthBoundsdNV"
external glDepthFunc : int -> unit = "glstub_glDepthFunc"
  "glstub_glDepthFunc"
external glDepthMask : bool -> unit = "glstub_glDepthMask"
  "glstub_glDepthMask"
external glDepthRange : float -> float -> unit = "glstub_glDepthRange"
  "glstub_glDepthRange"
external glDepthRangedNV : float -> float -> unit = "glstub_glDepthRangedNV"
  "glstub_glDepthRangedNV"
external glDepthRangefOES : float -> float -> unit
  = "glstub_glDepthRangefOES" "glstub_glDepthRangefOES"
external glDetachObjectARB : int -> int -> unit = "glstub_glDetachObjectARB"
  "glstub_glDetachObjectARB"
external glDetachShader : int -> int -> unit = "glstub_glDetachShader"
  "glstub_glDetachShader"
val glDetailTexFuncSGIS : int -> int -> float array -> unit
external glDisable : int -> unit = "glstub_glDisable" "glstub_glDisable"
external glDisableClientState : int -> unit = "glstub_glDisableClientState"
  "glstub_glDisableClientState"
external glDisableIndexedEXT : int -> int -> unit
  = "glstub_glDisableIndexedEXT" "glstub_glDisableIndexedEXT"
external glDisableVariantClientStateEXT : int -> unit
  = "glstub_glDisableVariantClientStateEXT"
  "glstub_glDisableVariantClientStateEXT"
external glDisableVertexAttribArray : int -> unit
  = "glstub_glDisableVertexAttribArray" "glstub_glDisableVertexAttribArray"
external glDisableVertexAttribArrayARB : int -> unit
  = "glstub_glDisableVertexAttribArrayARB"
  "glstub_glDisableVertexAttribArrayARB"
external glDrawArrays : int -> int -> int -> unit = "glstub_glDrawArrays"
  "glstub_glDrawArrays"
external glDrawArraysEXT : int -> int -> int -> unit
  = "glstub_glDrawArraysEXT" "glstub_glDrawArraysEXT"
external glDrawArraysInstancedEXT : int -> int -> int -> int -> unit
  = "glstub_glDrawArraysInstancedEXT" "glstub_glDrawArraysInstancedEXT"
external glDrawBuffer : int -> unit = "glstub_glDrawBuffer"
  "glstub_glDrawBuffer"
external glDrawBufferRegionEXT :
  int -> int -> int -> int -> int -> int -> int -> unit
  = "glstub_glDrawBufferRegionEXT_byte" "glstub_glDrawBufferRegionEXT"
val glDrawBuffers : int -> int array -> unit
val glDrawBuffersARB : int -> int array -> unit
val glDrawBuffersATI : int -> int array -> unit
external glDrawElementArrayAPPLE : int -> int -> int -> unit
  = "glstub_glDrawElementArrayAPPLE" "glstub_glDrawElementArrayAPPLE"
external glDrawElementArrayATI : int -> int -> unit
  = "glstub_glDrawElementArrayATI" "glstub_glDrawElementArrayATI"
external glDrawElements : int -> int -> int -> 'a -> unit
  = "glstub_glDrawElements" "glstub_glDrawElements"
external glDrawElementsInstancedEXT : int -> int -> int -> 'a -> int -> unit
  = "glstub_glDrawElementsInstancedEXT" "glstub_glDrawElementsInstancedEXT"
external glDrawPixels : int -> int -> int -> int -> 'a -> unit
  = "glstub_glDrawPixels" "glstub_glDrawPixels"
external glDrawRangeElementArrayAPPLE :
  int -> int -> int -> int -> int -> unit
  = "glstub_glDrawRangeElementArrayAPPLE"
  "glstub_glDrawRangeElementArrayAPPLE"
external glDrawRangeElementArrayATI : int -> int -> int -> int -> unit
  = "glstub_glDrawRangeElementArrayATI" "glstub_glDrawRangeElementArrayATI"
external glDrawRangeElements : int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glDrawRangeElements_byte" "glstub_glDrawRangeElements"
external glDrawRangeElementsEXT :
  int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glDrawRangeElementsEXT_byte" "glstub_glDrawRangeElementsEXT"
external glEdgeFlag : bool -> unit = "glstub_glEdgeFlag" "glstub_glEdgeFlag"
external glEdgeFlagPointer : int -> 'a -> unit = "glstub_glEdgeFlagPointer"
  "glstub_glEdgeFlagPointer"
val glEdgeFlagPointerEXT : int -> int -> bool array -> unit
external glEdgeFlagPointerListIBM : int -> word_matrix -> int -> unit
  = "glstub_glEdgeFlagPointerListIBM" "glstub_glEdgeFlagPointerListIBM"
val glEdgeFlagv : bool array -> unit
external glElementPointerAPPLE : int -> 'a -> unit
  = "glstub_glElementPointerAPPLE" "glstub_glElementPointerAPPLE"
external glElementPointerATI : int -> 'a -> unit
  = "glstub_glElementPointerATI" "glstub_glElementPointerATI"
external glEnable : int -> unit = "glstub_glEnable" "glstub_glEnable"
external glEnableClientState : int -> unit = "glstub_glEnableClientState"
  "glstub_glEnableClientState"
external glEnableIndexedEXT : int -> int -> unit
  = "glstub_glEnableIndexedEXT" "glstub_glEnableIndexedEXT"
external glEnableVariantClientStateEXT : int -> unit
  = "glstub_glEnableVariantClientStateEXT"
  "glstub_glEnableVariantClientStateEXT"
external glEnableVertexAttribArray : int -> unit
  = "glstub_glEnableVertexAttribArray" "glstub_glEnableVertexAttribArray"
external glEnableVertexAttribArrayARB : int -> unit
  = "glstub_glEnableVertexAttribArrayARB"
  "glstub_glEnableVertexAttribArrayARB"
external glEnd : unit -> unit = "glstub_glEnd" "glstub_glEnd"
external glEndFragmentShaderATI : unit -> unit
  = "glstub_glEndFragmentShaderATI" "glstub_glEndFragmentShaderATI"
external glEndList : unit -> unit = "glstub_glEndList" "glstub_glEndList"
external glEndOcclusionQueryNV : unit -> unit
  = "glstub_glEndOcclusionQueryNV" "glstub_glEndOcclusionQueryNV"
external glEndQuery : int -> unit = "glstub_glEndQuery" "glstub_glEndQuery"
external glEndQueryARB : int -> unit = "glstub_glEndQueryARB"
  "glstub_glEndQueryARB"
external glEndSceneEXT : unit -> unit = "glstub_glEndSceneEXT"
  "glstub_glEndSceneEXT"
external glEndTransformFeedbackNV : unit -> unit
  = "glstub_glEndTransformFeedbackNV" "glstub_glEndTransformFeedbackNV"
external glEndVertexShaderEXT : unit -> unit = "glstub_glEndVertexShaderEXT"
  "glstub_glEndVertexShaderEXT"
external glEvalCoord1d : float -> unit = "glstub_glEvalCoord1d"
  "glstub_glEvalCoord1d"
external glEvalCoord1dv : float array -> unit = "glstub_glEvalCoord1dv"
  "glstub_glEvalCoord1dv"
external glEvalCoord1f : float -> unit = "glstub_glEvalCoord1f"
  "glstub_glEvalCoord1f"
val glEvalCoord1fv : float array -> unit
external glEvalCoord2d : float -> float -> unit = "glstub_glEvalCoord2d"
  "glstub_glEvalCoord2d"
external glEvalCoord2dv : float array -> unit = "glstub_glEvalCoord2dv"
  "glstub_glEvalCoord2dv"
external glEvalCoord2f : float -> float -> unit = "glstub_glEvalCoord2f"
  "glstub_glEvalCoord2f"
val glEvalCoord2fv : float array -> unit
external glEvalMapsNV : int -> int -> unit = "glstub_glEvalMapsNV"
  "glstub_glEvalMapsNV"
external glEvalMesh1 : int -> int -> int -> unit = "glstub_glEvalMesh1"
  "glstub_glEvalMesh1"
external glEvalMesh2 : int -> int -> int -> int -> int -> unit
  = "glstub_glEvalMesh2" "glstub_glEvalMesh2"
external glEvalPoint1 : int -> unit = "glstub_glEvalPoint1"
  "glstub_glEvalPoint1"
external glEvalPoint2 : int -> int -> unit = "glstub_glEvalPoint2"
  "glstub_glEvalPoint2"
val glExecuteProgramNV : int -> int -> float array -> unit
external glExtractComponentEXT : int -> int -> int -> unit
  = "glstub_glExtractComponentEXT" "glstub_glExtractComponentEXT"
val glFeedbackBuffer : int -> int -> float array -> unit
external glFinalCombinerInputNV : int -> int -> int -> int -> unit
  = "glstub_glFinalCombinerInputNV" "glstub_glFinalCombinerInputNV"
external glFinish : unit -> unit = "glstub_glFinish" "glstub_glFinish"
val glFinishAsyncSGIX : int array -> int
external glFinishFenceAPPLE : int -> unit = "glstub_glFinishFenceAPPLE"
  "glstub_glFinishFenceAPPLE"
external glFinishFenceNV : int -> unit = "glstub_glFinishFenceNV"
  "glstub_glFinishFenceNV"
external glFinishObjectAPPLE : int -> int -> unit
  = "glstub_glFinishObjectAPPLE" "glstub_glFinishObjectAPPLE"
external glFinishTextureSUNX : unit -> unit = "glstub_glFinishTextureSUNX"
  "glstub_glFinishTextureSUNX"
external glFlush : unit -> unit = "glstub_glFlush" "glstub_glFlush"
external glFlushPixelDataRangeNV : int -> unit
  = "glstub_glFlushPixelDataRangeNV" "glstub_glFlushPixelDataRangeNV"
external glFlushRasterSGIX : unit -> unit = "glstub_glFlushRasterSGIX"
  "glstub_glFlushRasterSGIX"
external glFlushVertexArrayRangeAPPLE : int -> 'a -> unit
  = "glstub_glFlushVertexArrayRangeAPPLE"
  "glstub_glFlushVertexArrayRangeAPPLE"
external glFlushVertexArrayRangeNV : unit -> unit
  = "glstub_glFlushVertexArrayRangeNV" "glstub_glFlushVertexArrayRangeNV"
external glFogCoordPointer : int -> int -> 'a -> unit
  = "glstub_glFogCoordPointer" "glstub_glFogCoordPointer"
external glFogCoordPointerEXT : int -> int -> 'a -> unit
  = "glstub_glFogCoordPointerEXT" "glstub_glFogCoordPointerEXT"
external glFogCoordPointerListIBM : int -> int -> 'a -> int -> unit
  = "glstub_glFogCoordPointerListIBM" "glstub_glFogCoordPointerListIBM"
external glFogCoordd : float -> unit = "glstub_glFogCoordd"
  "glstub_glFogCoordd"
external glFogCoorddEXT : float -> unit = "glstub_glFogCoorddEXT"
  "glstub_glFogCoorddEXT"
external glFogCoorddv : float array -> unit = "glstub_glFogCoorddv"
  "glstub_glFogCoorddv"
external glFogCoorddvEXT : float array -> unit = "glstub_glFogCoorddvEXT"
  "glstub_glFogCoorddvEXT"
external glFogCoordf : float -> unit = "glstub_glFogCoordf"
  "glstub_glFogCoordf"
external glFogCoordfEXT : float -> unit = "glstub_glFogCoordfEXT"
  "glstub_glFogCoordfEXT"
val glFogCoordfv : float array -> unit
val glFogCoordfvEXT : float array -> unit
external glFogCoordhNV : int -> unit = "glstub_glFogCoordhNV"
  "glstub_glFogCoordhNV"
val glFogCoordhvNV : int array -> unit
val glFogFuncSGIS : int -> float array -> unit
external glFogf : int -> float -> unit = "glstub_glFogf" "glstub_glFogf"
val glFogfv : int -> float array -> unit
external glFogi : int -> int -> unit = "glstub_glFogi" "glstub_glFogi"
val glFogiv : int -> int array -> unit
external glFragmentColorMaterialEXT : int -> int -> unit
  = "glstub_glFragmentColorMaterialEXT" "glstub_glFragmentColorMaterialEXT"
external glFragmentColorMaterialSGIX : int -> int -> unit
  = "glstub_glFragmentColorMaterialSGIX" "glstub_glFragmentColorMaterialSGIX"
external glFragmentLightModelfEXT : int -> float -> unit
  = "glstub_glFragmentLightModelfEXT" "glstub_glFragmentLightModelfEXT"
external glFragmentLightModelfSGIX : int -> float -> unit
  = "glstub_glFragmentLightModelfSGIX" "glstub_glFragmentLightModelfSGIX"
val glFragmentLightModelfvEXT : int -> float array -> unit
val glFragmentLightModelfvSGIX : int -> float array -> unit
external glFragmentLightModeliEXT : int -> int -> unit
  = "glstub_glFragmentLightModeliEXT" "glstub_glFragmentLightModeliEXT"
external glFragmentLightModeliSGIX : int -> int -> unit
  = "glstub_glFragmentLightModeliSGIX" "glstub_glFragmentLightModeliSGIX"
val glFragmentLightModelivEXT : int -> int array -> unit
val glFragmentLightModelivSGIX : int -> int array -> unit
external glFragmentLightfEXT : int -> int -> float -> unit
  = "glstub_glFragmentLightfEXT" "glstub_glFragmentLightfEXT"
external glFragmentLightfSGIX : int -> int -> float -> unit
  = "glstub_glFragmentLightfSGIX" "glstub_glFragmentLightfSGIX"
val glFragmentLightfvEXT : int -> int -> float array -> unit
val glFragmentLightfvSGIX : int -> int -> float array -> unit
external glFragmentLightiEXT : int -> int -> int -> unit
  = "glstub_glFragmentLightiEXT" "glstub_glFragmentLightiEXT"
external glFragmentLightiSGIX : int -> int -> int -> unit
  = "glstub_glFragmentLightiSGIX" "glstub_glFragmentLightiSGIX"
val glFragmentLightivEXT : int -> int -> int array -> unit
val glFragmentLightivSGIX : int -> int -> int array -> unit
external glFragmentMaterialfEXT : int -> int -> float -> unit
  = "glstub_glFragmentMaterialfEXT" "glstub_glFragmentMaterialfEXT"
external glFragmentMaterialfSGIX : int -> int -> float -> unit
  = "glstub_glFragmentMaterialfSGIX" "glstub_glFragmentMaterialfSGIX"
val glFragmentMaterialfvEXT : int -> int -> float array -> unit
val glFragmentMaterialfvSGIX : int -> int -> float array -> unit
external glFragmentMaterialiEXT : int -> int -> int -> unit
  = "glstub_glFragmentMaterialiEXT" "glstub_glFragmentMaterialiEXT"
external glFragmentMaterialiSGIX : int -> int -> int -> unit
  = "glstub_glFragmentMaterialiSGIX" "glstub_glFragmentMaterialiSGIX"
val glFragmentMaterialivEXT : int -> int -> int array -> unit
val glFragmentMaterialivSGIX : int -> int -> int array -> unit
external glFrameZoomSGIX : int -> unit = "glstub_glFrameZoomSGIX"
  "glstub_glFrameZoomSGIX"
external glFramebufferRenderbufferEXT : int -> int -> int -> int -> unit
  = "glstub_glFramebufferRenderbufferEXT"
  "glstub_glFramebufferRenderbufferEXT"
external glFramebufferTexture1DEXT : int -> int -> int -> int -> int -> unit
  = "glstub_glFramebufferTexture1DEXT" "glstub_glFramebufferTexture1DEXT"
external glFramebufferTexture2DEXT : int -> int -> int -> int -> int -> unit
  = "glstub_glFramebufferTexture2DEXT" "glstub_glFramebufferTexture2DEXT"
external glFramebufferTexture3DEXT :
  int -> int -> int -> int -> int -> int -> unit
  = "glstub_glFramebufferTexture3DEXT_byte"
  "glstub_glFramebufferTexture3DEXT"
external glFramebufferTextureEXT : int -> int -> int -> int -> unit
  = "glstub_glFramebufferTextureEXT" "glstub_glFramebufferTextureEXT"
external glFramebufferTextureFaceEXT :
  int -> int -> int -> int -> int -> unit
  = "glstub_glFramebufferTextureFaceEXT" "glstub_glFramebufferTextureFaceEXT"
external glFramebufferTextureLayerEXT :
  int -> int -> int -> int -> int -> unit
  = "glstub_glFramebufferTextureLayerEXT"
  "glstub_glFramebufferTextureLayerEXT"
external glFreeObjectBufferATI : int -> unit = "glstub_glFreeObjectBufferATI"
  "glstub_glFreeObjectBufferATI"
external glFrontFace : int -> unit = "glstub_glFrontFace"
  "glstub_glFrontFace"
external glFrustum :
  float -> float -> float -> float -> float -> float -> unit
  = "glstub_glFrustum_byte" "glstub_glFrustum"
external glFrustumfOES :
  float -> float -> float -> float -> float -> float -> unit
  = "glstub_glFrustumfOES_byte" "glstub_glFrustumfOES"
external glGenAsyncMarkersSGIX : int -> int = "glstub_glGenAsyncMarkersSGIX"
  "glstub_glGenAsyncMarkersSGIX"
val glGenBuffers : int -> int array -> unit
val glGenBuffersARB : int -> int array -> unit
val glGenFencesAPPLE : int -> int array -> unit
val glGenFencesNV : int -> int array -> unit
external glGenFragmentShadersATI : int -> int
  = "glstub_glGenFragmentShadersATI" "glstub_glGenFragmentShadersATI"
val glGenFramebuffersEXT : int -> int array -> unit
external glGenLists : int -> int = "glstub_glGenLists" "glstub_glGenLists"
val glGenOcclusionQueriesNV : int -> int array -> unit
val glGenProgramsARB : int -> int array -> unit
val glGenProgramsNV : int -> int array -> unit
val glGenQueries : int -> int array -> unit
val glGenQueriesARB : int -> int array -> unit
val glGenRenderbuffersEXT : int -> int array -> unit
external glGenSymbolsEXT : int -> int -> int -> int -> int
  = "glstub_glGenSymbolsEXT" "glstub_glGenSymbolsEXT"
val glGenTextures : int -> int array -> unit
val glGenTexturesEXT : int -> int array -> unit
val glGenVertexArraysAPPLE : int -> int array -> unit
external glGenVertexShadersEXT : int -> int = "glstub_glGenVertexShadersEXT"
  "glstub_glGenVertexShadersEXT"
external glGenerateMipmapEXT : int -> unit = "glstub_glGenerateMipmapEXT"
  "glstub_glGenerateMipmapEXT"
val glGetActiveAttrib :
  int -> int -> int -> int array -> int array -> int array -> string -> unit
val glGetActiveAttribARB :
  int -> int -> int -> int array -> int array -> int array -> string -> unit
val glGetActiveUniform :
  int -> int -> int -> int array -> int array -> int array -> string -> unit
val glGetActiveUniformARB :
  int -> int -> int -> int array -> int array -> int array -> string -> unit
val glGetActiveVaryingNV :
  int -> int -> int -> int array -> int array -> int array -> string -> unit
val glGetArrayObjectfvATI : int -> int -> float array -> unit
val glGetArrayObjectivATI : int -> int -> int array -> unit
val glGetAttachedObjectsARB : int -> int -> int array -> int array -> unit
val glGetAttachedShaders : int -> int -> int array -> int array -> unit
external glGetAttribLocation : int -> string -> int
  = "glstub_glGetAttribLocation" "glstub_glGetAttribLocation"
external glGetAttribLocationARB : int -> string -> int
  = "glstub_glGetAttribLocationARB" "glstub_glGetAttribLocationARB"
val glGetBooleanIndexedvEXT : int -> int -> bool array -> unit
val glGetBooleanv : int -> bool array -> unit
val glGetBufferParameteriv : int -> int -> int array -> unit
val glGetBufferParameterivARB : int -> int -> int array -> unit
external glGetBufferPointerv : int -> int -> 'a -> unit
  = "glstub_glGetBufferPointerv" "glstub_glGetBufferPointerv"
external glGetBufferPointervARB : int -> int -> 'a -> unit
  = "glstub_glGetBufferPointervARB" "glstub_glGetBufferPointervARB"
external glGetBufferSubData : int -> int -> int -> 'a -> unit
  = "glstub_glGetBufferSubData" "glstub_glGetBufferSubData"
external glGetBufferSubDataARB : int -> int -> int -> 'a -> unit
  = "glstub_glGetBufferSubDataARB" "glstub_glGetBufferSubDataARB"
external glGetClipPlane : int -> float array -> unit
  = "glstub_glGetClipPlane" "glstub_glGetClipPlane"
val glGetClipPlanefOES : int -> float array -> unit
external glGetColorTable : int -> int -> int -> 'a -> unit
  = "glstub_glGetColorTable" "glstub_glGetColorTable"
external glGetColorTableEXT : int -> int -> int -> 'a -> unit
  = "glstub_glGetColorTableEXT" "glstub_glGetColorTableEXT"
val glGetColorTableParameterfv : int -> int -> float array -> unit
val glGetColorTableParameterfvEXT : int -> int -> float array -> unit
val glGetColorTableParameterfvSGI : int -> int -> float array -> unit
val glGetColorTableParameteriv : int -> int -> int array -> unit
val glGetColorTableParameterivEXT : int -> int -> int array -> unit
val glGetColorTableParameterivSGI : int -> int -> int array -> unit
external glGetColorTableSGI : int -> int -> int -> 'a -> unit
  = "glstub_glGetColorTableSGI" "glstub_glGetColorTableSGI"
val glGetCombinerInputParameterfvNV :
  int -> int -> int -> int -> float array -> unit
val glGetCombinerInputParameterivNV :
  int -> int -> int -> int -> int array -> unit
val glGetCombinerOutputParameterfvNV :
  int -> int -> int -> float array -> unit
val glGetCombinerOutputParameterivNV : int -> int -> int -> int array -> unit
val glGetCombinerStageParameterfvNV : int -> int -> float array -> unit
external glGetCompressedTexImage : int -> int -> 'a -> unit
  = "glstub_glGetCompressedTexImage" "glstub_glGetCompressedTexImage"
external glGetCompressedTexImageARB : int -> int -> 'a -> unit
  = "glstub_glGetCompressedTexImageARB" "glstub_glGetCompressedTexImageARB"
external glGetConvolutionFilter : int -> int -> int -> 'a -> unit
  = "glstub_glGetConvolutionFilter" "glstub_glGetConvolutionFilter"
external glGetConvolutionFilterEXT : int -> int -> int -> 'a -> unit
  = "glstub_glGetConvolutionFilterEXT" "glstub_glGetConvolutionFilterEXT"
val glGetConvolutionParameterfv : int -> int -> float array -> unit
val glGetConvolutionParameterfvEXT : int -> int -> float array -> unit
val glGetConvolutionParameteriv : int -> int -> int array -> unit
val glGetConvolutionParameterivEXT : int -> int -> int array -> unit
val glGetDetailTexFuncSGIS : int -> float array -> unit
external glGetDoublev : int -> float array -> unit = "glstub_glGetDoublev"
  "glstub_glGetDoublev"
external glGetError : unit -> int = "glstub_glGetError" "glstub_glGetError"
val glGetFenceivNV : int -> int -> int array -> unit
val glGetFinalCombinerInputParameterfvNV : int -> int -> float array -> unit
val glGetFinalCombinerInputParameterivNV : int -> int -> int array -> unit
val glGetFloatv : int -> float array -> unit
val glGetFogFuncSGIS : float array -> unit
external glGetFragDataLocationEXT : int -> string -> int
  = "glstub_glGetFragDataLocationEXT" "glstub_glGetFragDataLocationEXT"
val glGetFragmentLightfvEXT : int -> int -> float array -> unit
val glGetFragmentLightfvSGIX : int -> int -> float array -> unit
val glGetFragmentLightivEXT : int -> int -> int array -> unit
val glGetFragmentLightivSGIX : int -> int -> int array -> unit
val glGetFragmentMaterialfvEXT : int -> int -> float array -> unit
val glGetFragmentMaterialfvSGIX : int -> int -> float array -> unit
val glGetFragmentMaterialivEXT : int -> int -> int array -> unit
val glGetFragmentMaterialivSGIX : int -> int -> int array -> unit
val glGetFramebufferAttachmentParameterivEXT :
  int -> int -> int -> int array -> unit
external glGetHandleARB : int -> int = "glstub_glGetHandleARB"
  "glstub_glGetHandleARB"
external glGetHistogram : int -> bool -> int -> int -> 'a -> unit
  = "glstub_glGetHistogram" "glstub_glGetHistogram"
external glGetHistogramEXT : int -> bool -> int -> int -> 'a -> unit
  = "glstub_glGetHistogramEXT" "glstub_glGetHistogramEXT"
val glGetHistogramParameterfv : int -> int -> float array -> unit
val glGetHistogramParameterfvEXT : int -> int -> float array -> unit
val glGetHistogramParameteriv : int -> int -> int array -> unit
val glGetHistogramParameterivEXT : int -> int -> int array -> unit
val glGetImageTransformParameterfvHP : int -> int -> float array -> unit
val glGetImageTransformParameterivHP : int -> int -> int array -> unit
val glGetInfoLogARB : int -> int -> int array -> string -> unit
val glGetIntegerIndexedvEXT : int -> int -> int array -> unit
val glGetIntegerv : int -> int array -> unit
val glGetInvariantBooleanvEXT : int -> int -> bool array -> unit
val glGetInvariantFloatvEXT : int -> int -> float array -> unit
val glGetInvariantIntegervEXT : int -> int -> int array -> unit
val glGetLightfv : int -> int -> float array -> unit
val glGetLightiv : int -> int -> int array -> unit
val glGetLocalConstantBooleanvEXT : int -> int -> bool array -> unit
val glGetLocalConstantFloatvEXT : int -> int -> float array -> unit
val glGetLocalConstantIntegervEXT : int -> int -> int array -> unit
val glGetMapAttribParameterfvNV : int -> int -> int -> float array -> unit
val glGetMapAttribParameterivNV : int -> int -> int -> int array -> unit
external glGetMapControlPointsNV :
  int -> int -> int -> int -> int -> bool -> 'a -> unit
  = "glstub_glGetMapControlPointsNV_byte" "glstub_glGetMapControlPointsNV"
val glGetMapParameterfvNV : int -> int -> float array -> unit
val glGetMapParameterivNV : int -> int -> int array -> unit
external glGetMapdv : int -> int -> float array -> unit = "glstub_glGetMapdv"
  "glstub_glGetMapdv"
val glGetMapfv : int -> int -> float array -> unit
val glGetMapiv : int -> int -> int array -> unit
val glGetMaterialfv : int -> int -> float array -> unit
val glGetMaterialiv : int -> int -> int array -> unit
external glGetMinmax : int -> bool -> int -> int -> 'a -> unit
  = "glstub_glGetMinmax" "glstub_glGetMinmax"
external glGetMinmaxEXT : int -> bool -> int -> int -> 'a -> unit
  = "glstub_glGetMinmaxEXT" "glstub_glGetMinmaxEXT"
val glGetMinmaxParameterfv : int -> int -> float array -> unit
val glGetMinmaxParameterfvEXT : int -> int -> float array -> unit
val glGetMinmaxParameteriv : int -> int -> int array -> unit
val glGetMinmaxParameterivEXT : int -> int -> int array -> unit
val glGetObjectBufferfvATI : int -> int -> float array -> unit
val glGetObjectBufferivATI : int -> int -> int array -> unit
val glGetObjectParameterfvARB : int -> int -> float array -> unit
val glGetObjectParameterivARB : int -> int -> int array -> unit
val glGetOcclusionQueryivNV : int -> int -> int array -> unit
val glGetOcclusionQueryuivNV : int -> int -> int array -> unit
val glGetPixelMapfv : int -> float array -> unit
val glGetPixelMapuiv : int -> int array -> unit
val glGetPixelMapusv : int -> int array -> unit
val glGetPixelTransformParameterfvEXT : int -> int -> float array -> unit
val glGetPixelTransformParameterivEXT : int -> int -> int array -> unit
external glGetPointerv : int -> 'a -> unit = "glstub_glGetPointerv"
  "glstub_glGetPointerv"
external glGetPointervEXT : int -> 'a -> unit = "glstub_glGetPointervEXT"
  "glstub_glGetPointervEXT"
val glGetPolygonStipple : int array -> unit
external glGetProgramEnvParameterdvARB : int -> int -> float array -> unit
  = "glstub_glGetProgramEnvParameterdvARB"
  "glstub_glGetProgramEnvParameterdvARB"
val glGetProgramEnvParameterfvARB : int -> int -> float array -> unit
val glGetProgramInfoLog : int -> int -> int array -> string -> unit
external glGetProgramLocalParameterdvARB : int -> int -> float array -> unit
  = "glstub_glGetProgramLocalParameterdvARB"
  "glstub_glGetProgramLocalParameterdvARB"
val glGetProgramLocalParameterfvARB : int -> int -> float array -> unit
val glGetProgramNamedParameterdvNV :
  int -> int -> int array -> float array -> unit
val glGetProgramNamedParameterfvNV :
  int -> int -> int array -> float array -> unit
external glGetProgramParameterdvNV : int -> int -> int -> float array -> unit
  = "glstub_glGetProgramParameterdvNV" "glstub_glGetProgramParameterdvNV"
val glGetProgramParameterfvNV : int -> int -> int -> float array -> unit
external glGetProgramStringARB : int -> int -> 'a -> unit
  = "glstub_glGetProgramStringARB" "glstub_glGetProgramStringARB"
val glGetProgramStringNV : int -> int -> int array -> unit
val glGetProgramiv : int -> int -> int array -> unit
val glGetProgramivARB : int -> int -> int array -> unit
val glGetProgramivNV : int -> int -> int array -> unit
val glGetQueryObjectiv : int -> int -> int array -> unit
val glGetQueryObjectivARB : int -> int -> int array -> unit
val glGetQueryObjectuiv : int -> int -> int array -> unit
val glGetQueryObjectuivARB : int -> int -> int array -> unit
val glGetQueryiv : int -> int -> int array -> unit
val glGetQueryivARB : int -> int -> int array -> unit
val glGetRenderbufferParameterivEXT : int -> int -> int array -> unit
external glGetSeparableFilter : int -> int -> int -> 'a -> 'a -> 'a -> unit
  = "glstub_glGetSeparableFilter_byte" "glstub_glGetSeparableFilter"
external glGetSeparableFilterEXT :
  int -> int -> int -> 'a -> 'a -> 'a -> unit
  = "glstub_glGetSeparableFilterEXT_byte" "glstub_glGetSeparableFilterEXT"
val glGetShaderInfoLog : int -> int -> int array -> string -> unit
val glGetShaderSource : int -> int -> int array -> string -> unit
val glGetShaderSourceARB : int -> int -> int array -> string -> unit
val glGetShaderiv : int -> int -> int array -> unit
val glGetSharpenTexFuncSGIS : int -> float array -> unit
external glGetString : int -> string = "glstub_glGetString"
  "glstub_glGetString"
val glGetTexBumpParameterfvATI : int -> float array -> unit
val glGetTexBumpParameterivATI : int -> int array -> unit
val glGetTexEnvfv : int -> int -> float array -> unit
val glGetTexEnviv : int -> int -> int array -> unit
val glGetTexFilterFuncSGIS : int -> int -> float array -> unit
external glGetTexGendv : int -> int -> float array -> unit
  = "glstub_glGetTexGendv" "glstub_glGetTexGendv"
val glGetTexGenfv : int -> int -> float array -> unit
val glGetTexGeniv : int -> int -> int array -> unit
external glGetTexImage : int -> int -> int -> int -> 'a -> unit
  = "glstub_glGetTexImage" "glstub_glGetTexImage"
val glGetTexLevelParameterfv : int -> int -> int -> float array -> unit
val glGetTexLevelParameteriv : int -> int -> int -> int array -> unit
val glGetTexParameterIivEXT : int -> int -> int array -> unit
val glGetTexParameterIuivEXT : int -> int -> int array -> unit
external glGetTexParameterPointervAPPLE : int -> int -> 'a -> unit
  = "glstub_glGetTexParameterPointervAPPLE"
  "glstub_glGetTexParameterPointervAPPLE"
val glGetTexParameterfv : int -> int -> float array -> unit
val glGetTexParameteriv : int -> int -> int array -> unit
val glGetTrackMatrixivNV : int -> int -> int -> int array -> unit
val glGetTransformFeedbackVaryingNV : int -> int -> int array -> unit
external glGetUniformBufferSizeEXT : int -> int -> int
  = "glstub_glGetUniformBufferSizeEXT" "glstub_glGetUniformBufferSizeEXT"
external glGetUniformLocation : int -> string -> int
  = "glstub_glGetUniformLocation" "glstub_glGetUniformLocation"
external glGetUniformLocationARB : int -> string -> int
  = "glstub_glGetUniformLocationARB" "glstub_glGetUniformLocationARB"
external glGetUniformOffsetEXT : int -> int -> int
  = "glstub_glGetUniformOffsetEXT" "glstub_glGetUniformOffsetEXT"
val glGetUniformfv : int -> int -> float array -> unit
val glGetUniformfvARB : int -> int -> float array -> unit
val glGetUniformiv : int -> int -> int array -> unit
val glGetUniformivARB : int -> int -> int array -> unit
val glGetUniformuivEXT : int -> int -> int array -> unit
val glGetVariantArrayObjectfvATI : int -> int -> float array -> unit
val glGetVariantArrayObjectivATI : int -> int -> int array -> unit
val glGetVariantBooleanvEXT : int -> int -> bool array -> unit
val glGetVariantFloatvEXT : int -> int -> float array -> unit
val glGetVariantIntegervEXT : int -> int -> int array -> unit
external glGetVariantPointervEXT : int -> int -> 'a -> unit
  = "glstub_glGetVariantPointervEXT" "glstub_glGetVariantPointervEXT"
external glGetVaryingLocationNV : int -> string -> int
  = "glstub_glGetVaryingLocationNV" "glstub_glGetVaryingLocationNV"
val glGetVertexAttribArrayObjectfvATI : int -> int -> float array -> unit
val glGetVertexAttribArrayObjectivATI : int -> int -> int array -> unit
val glGetVertexAttribIivEXT : int -> int -> int array -> unit
val glGetVertexAttribIuivEXT : int -> int -> int array -> unit
external glGetVertexAttribPointerv : int -> int -> 'a -> unit
  = "glstub_glGetVertexAttribPointerv" "glstub_glGetVertexAttribPointerv"
external glGetVertexAttribPointervARB : int -> int -> 'a -> unit
  = "glstub_glGetVertexAttribPointervARB"
  "glstub_glGetVertexAttribPointervARB"
external glGetVertexAttribPointervNV : int -> int -> 'a -> unit
  = "glstub_glGetVertexAttribPointervNV" "glstub_glGetVertexAttribPointervNV"
external glGetVertexAttribdv : int -> int -> float array -> unit
  = "glstub_glGetVertexAttribdv" "glstub_glGetVertexAttribdv"
external glGetVertexAttribdvARB : int -> int -> float array -> unit
  = "glstub_glGetVertexAttribdvARB" "glstub_glGetVertexAttribdvARB"
external glGetVertexAttribdvNV : int -> int -> float array -> unit
  = "glstub_glGetVertexAttribdvNV" "glstub_glGetVertexAttribdvNV"
val glGetVertexAttribfv : int -> int -> float array -> unit
val glGetVertexAttribfvARB : int -> int -> float array -> unit
val glGetVertexAttribfvNV : int -> int -> float array -> unit
val glGetVertexAttribiv : int -> int -> int array -> unit
val glGetVertexAttribivARB : int -> int -> int array -> unit
val glGetVertexAttribivNV : int -> int -> int array -> unit
external glGlobalAlphaFactorbSUN : int -> unit
  = "glstub_glGlobalAlphaFactorbSUN" "glstub_glGlobalAlphaFactorbSUN"
external glGlobalAlphaFactordSUN : float -> unit
  = "glstub_glGlobalAlphaFactordSUN" "glstub_glGlobalAlphaFactordSUN"
external glGlobalAlphaFactorfSUN : float -> unit
  = "glstub_glGlobalAlphaFactorfSUN" "glstub_glGlobalAlphaFactorfSUN"
external glGlobalAlphaFactoriSUN : int -> unit
  = "glstub_glGlobalAlphaFactoriSUN" "glstub_glGlobalAlphaFactoriSUN"
external glGlobalAlphaFactorsSUN : int -> unit
  = "glstub_glGlobalAlphaFactorsSUN" "glstub_glGlobalAlphaFactorsSUN"
external glGlobalAlphaFactorubSUN : int -> unit
  = "glstub_glGlobalAlphaFactorubSUN" "glstub_glGlobalAlphaFactorubSUN"
external glGlobalAlphaFactoruiSUN : int -> unit
  = "glstub_glGlobalAlphaFactoruiSUN" "glstub_glGlobalAlphaFactoruiSUN"
external glGlobalAlphaFactorusSUN : int -> unit
  = "glstub_glGlobalAlphaFactorusSUN" "glstub_glGlobalAlphaFactorusSUN"
external glHint : int -> int -> unit = "glstub_glHint" "glstub_glHint"
external glHistogram : int -> int -> int -> bool -> unit
  = "glstub_glHistogram" "glstub_glHistogram"
external glHistogramEXT : int -> int -> int -> bool -> unit
  = "glstub_glHistogramEXT" "glstub_glHistogramEXT"
external glImageTransformParameterfHP : int -> int -> float -> unit
  = "glstub_glImageTransformParameterfHP"
  "glstub_glImageTransformParameterfHP"
val glImageTransformParameterfvHP : int -> int -> float array -> unit
external glImageTransformParameteriHP : int -> int -> int -> unit
  = "glstub_glImageTransformParameteriHP"
  "glstub_glImageTransformParameteriHP"
val glImageTransformParameterivHP : int -> int -> int array -> unit
external glIndexFuncEXT : int -> float -> unit = "glstub_glIndexFuncEXT"
  "glstub_glIndexFuncEXT"
external glIndexMask : int -> unit = "glstub_glIndexMask"
  "glstub_glIndexMask"
external glIndexMaterialEXT : int -> int -> unit
  = "glstub_glIndexMaterialEXT" "glstub_glIndexMaterialEXT"
external glIndexPointer : int -> int -> 'a -> unit = "glstub_glIndexPointer"
  "glstub_glIndexPointer"
external glIndexPointerEXT : int -> int -> int -> 'a -> unit
  = "glstub_glIndexPointerEXT" "glstub_glIndexPointerEXT"
external glIndexPointerListIBM : int -> int -> 'a -> int -> unit
  = "glstub_glIndexPointerListIBM" "glstub_glIndexPointerListIBM"
external glIndexd : float -> unit = "glstub_glIndexd" "glstub_glIndexd"
external glIndexdv : float array -> unit = "glstub_glIndexdv"
  "glstub_glIndexdv"
external glIndexf : float -> unit = "glstub_glIndexf" "glstub_glIndexf"
val glIndexfv : float array -> unit
external glIndexi : int -> unit = "glstub_glIndexi" "glstub_glIndexi"
val glIndexiv : int array -> unit
external glIndexs : int -> unit = "glstub_glIndexs" "glstub_glIndexs"
val glIndexsv : int array -> unit
external glIndexub : int -> unit = "glstub_glIndexub" "glstub_glIndexub"
val glIndexubv : int array -> unit
external glInitNames : unit -> unit = "glstub_glInitNames"
  "glstub_glInitNames"
external glInsertComponentEXT : int -> int -> int -> unit
  = "glstub_glInsertComponentEXT" "glstub_glInsertComponentEXT"
external glInterleavedArrays : int -> int -> 'a -> unit
  = "glstub_glInterleavedArrays" "glstub_glInterleavedArrays"
external glIsAsyncMarkerSGIX : int -> bool = "glstub_glIsAsyncMarkerSGIX"
  "glstub_glIsAsyncMarkerSGIX"
external glIsBuffer : int -> bool = "glstub_glIsBuffer" "glstub_glIsBuffer"
external glIsBufferARB : int -> bool = "glstub_glIsBufferARB"
  "glstub_glIsBufferARB"
external glIsEnabled : int -> bool = "glstub_glIsEnabled"
  "glstub_glIsEnabled"
external glIsEnabledIndexedEXT : int -> int -> bool
  = "glstub_glIsEnabledIndexedEXT" "glstub_glIsEnabledIndexedEXT"
external glIsFenceAPPLE : int -> bool = "glstub_glIsFenceAPPLE"
  "glstub_glIsFenceAPPLE"
external glIsFenceNV : int -> bool = "glstub_glIsFenceNV"
  "glstub_glIsFenceNV"
external glIsFramebufferEXT : int -> bool = "glstub_glIsFramebufferEXT"
  "glstub_glIsFramebufferEXT"
external glIsList : int -> bool = "glstub_glIsList" "glstub_glIsList"
external glIsObjectBufferATI : int -> bool = "glstub_glIsObjectBufferATI"
  "glstub_glIsObjectBufferATI"
external glIsOcclusionQueryNV : int -> bool = "glstub_glIsOcclusionQueryNV"
  "glstub_glIsOcclusionQueryNV"
external glIsProgram : int -> bool = "glstub_glIsProgram"
  "glstub_glIsProgram"
external glIsProgramARB : int -> bool = "glstub_glIsProgramARB"
  "glstub_glIsProgramARB"
external glIsProgramNV : int -> bool = "glstub_glIsProgramNV"
  "glstub_glIsProgramNV"
external glIsQuery : int -> bool = "glstub_glIsQuery" "glstub_glIsQuery"
external glIsQueryARB : int -> bool = "glstub_glIsQueryARB"
  "glstub_glIsQueryARB"
external glIsRenderbufferEXT : int -> bool = "glstub_glIsRenderbufferEXT"
  "glstub_glIsRenderbufferEXT"
external glIsShader : int -> bool = "glstub_glIsShader" "glstub_glIsShader"
external glIsTexture : int -> bool = "glstub_glIsTexture"
  "glstub_glIsTexture"
external glIsTextureEXT : int -> bool = "glstub_glIsTextureEXT"
  "glstub_glIsTextureEXT"
external glIsVariantEnabledEXT : int -> int -> bool
  = "glstub_glIsVariantEnabledEXT" "glstub_glIsVariantEnabledEXT"
external glIsVertexArrayAPPLE : int -> bool = "glstub_glIsVertexArrayAPPLE"
  "glstub_glIsVertexArrayAPPLE"
external glLightEnviEXT : int -> int -> unit = "glstub_glLightEnviEXT"
  "glstub_glLightEnviEXT"
external glLightModelf : int -> float -> unit = "glstub_glLightModelf"
  "glstub_glLightModelf"
val glLightModelfv : int -> float array -> unit
external glLightModeli : int -> int -> unit = "glstub_glLightModeli"
  "glstub_glLightModeli"
val glLightModeliv : int -> int array -> unit
external glLightf : int -> int -> float -> unit = "glstub_glLightf"
  "glstub_glLightf"
val glLightfv : int -> int -> float array -> unit
external glLighti : int -> int -> int -> unit = "glstub_glLighti"
  "glstub_glLighti"
val glLightiv : int -> int -> int array -> unit
external glLineStipple : int -> int -> unit = "glstub_glLineStipple"
  "glstub_glLineStipple"
external glLineWidth : float -> unit = "glstub_glLineWidth"
  "glstub_glLineWidth"
external glLinkProgram : int -> unit = "glstub_glLinkProgram"
  "glstub_glLinkProgram"
external glLinkProgramARB : int -> unit = "glstub_glLinkProgramARB"
  "glstub_glLinkProgramARB"
external glListBase : int -> unit = "glstub_glListBase" "glstub_glListBase"
external glLoadIdentity : unit -> unit = "glstub_glLoadIdentity"
  "glstub_glLoadIdentity"
external glLoadMatrixd : float array -> unit = "glstub_glLoadMatrixd"
  "glstub_glLoadMatrixd"
val glLoadMatrixf : float array -> unit
external glLoadName : int -> unit = "glstub_glLoadName" "glstub_glLoadName"
val glLoadProgramNV : int -> int -> int -> int array -> unit
external glLoadTransposeMatrixd : float array -> unit
  = "glstub_glLoadTransposeMatrixd" "glstub_glLoadTransposeMatrixd"
external glLoadTransposeMatrixdARB : float array -> unit
  = "glstub_glLoadTransposeMatrixdARB" "glstub_glLoadTransposeMatrixdARB"
val glLoadTransposeMatrixf : float array -> unit
val glLoadTransposeMatrixfARB : float array -> unit
external glLockArraysEXT : int -> int -> unit = "glstub_glLockArraysEXT"
  "glstub_glLockArraysEXT"
external glLogicOp : int -> unit = "glstub_glLogicOp" "glstub_glLogicOp"
external glMap1d : int -> float -> float -> int -> int -> float array -> unit
  = "glstub_glMap1d_byte" "glstub_glMap1d"
val glMap1f : int -> float -> float -> int -> int -> float array -> unit
external glMap2d :
  int ->
  float ->
  float -> int -> int -> float -> float -> int -> int -> float array -> unit
  = "glstub_glMap2d_byte" "glstub_glMap2d"
val glMap2f :
  int ->
  float ->
  float -> int -> int -> float -> float -> int -> int -> float array -> unit
external glMapBuffer : int -> int -> 'a = "glstub_glMapBuffer"
  "glstub_glMapBuffer"
external glMapBufferARB : int -> int -> 'a = "glstub_glMapBufferARB"
  "glstub_glMapBufferARB"
external glMapControlPointsNV :
  int -> int -> int -> int -> int -> int -> int -> bool -> 'a -> unit
  = "glstub_glMapControlPointsNV_byte" "glstub_glMapControlPointsNV"
external glMapGrid1d : int -> float -> float -> unit = "glstub_glMapGrid1d"
  "glstub_glMapGrid1d"
external glMapGrid1f : int -> float -> float -> unit = "glstub_glMapGrid1f"
  "glstub_glMapGrid1f"
external glMapGrid2d : int -> float -> float -> int -> float -> float -> unit
  = "glstub_glMapGrid2d_byte" "glstub_glMapGrid2d"
external glMapGrid2f : int -> float -> float -> int -> float -> float -> unit
  = "glstub_glMapGrid2f_byte" "glstub_glMapGrid2f"
external glMapObjectBufferATI : int -> 'a = "glstub_glMapObjectBufferATI"
  "glstub_glMapObjectBufferATI"
val glMapParameterfvNV : int -> int -> float array -> unit
val glMapParameterivNV : int -> int -> int array -> unit
external glMaterialf : int -> int -> float -> unit = "glstub_glMaterialf"
  "glstub_glMaterialf"
val glMaterialfv : int -> int -> float array -> unit
external glMateriali : int -> int -> int -> unit = "glstub_glMateriali"
  "glstub_glMateriali"
val glMaterialiv : int -> int -> int array -> unit
external glMatrixIndexPointerARB : int -> int -> int -> 'a -> unit
  = "glstub_glMatrixIndexPointerARB" "glstub_glMatrixIndexPointerARB"
val glMatrixIndexubvARB : int -> int array -> unit
val glMatrixIndexuivARB : int -> int array -> unit
val glMatrixIndexusvARB : int -> int array -> unit
external glMatrixMode : int -> unit = "glstub_glMatrixMode"
  "glstub_glMatrixMode"
external glMinmax : int -> int -> bool -> unit = "glstub_glMinmax"
  "glstub_glMinmax"
external glMinmaxEXT : int -> int -> bool -> unit = "glstub_glMinmaxEXT"
  "glstub_glMinmaxEXT"
external glMultMatrixd : float array -> unit = "glstub_glMultMatrixd"
  "glstub_glMultMatrixd"
val glMultMatrixf : float array -> unit
external glMultTransposeMatrixd : float array -> unit
  = "glstub_glMultTransposeMatrixd" "glstub_glMultTransposeMatrixd"
external glMultTransposeMatrixdARB : float array -> unit
  = "glstub_glMultTransposeMatrixdARB" "glstub_glMultTransposeMatrixdARB"
val glMultTransposeMatrixf : float array -> unit
val glMultTransposeMatrixfARB : float array -> unit
val glMultiDrawArrays : int -> int array -> int array -> int -> unit
val glMultiDrawArraysEXT : int -> int array -> int array -> int -> unit
val glMultiDrawElementArrayAPPLE :
  int -> int array -> int array -> int -> unit
val glMultiDrawElements : int -> int array -> int -> 'a -> int -> unit
val glMultiDrawElementsEXT : int -> int array -> int -> 'a -> int -> unit
val glMultiDrawRangeElementArrayAPPLE :
  int -> int -> int -> int array -> int array -> int -> unit
val glMultiModeDrawArraysIBM :
  int array -> int array -> int array -> int -> int -> unit
val glMultiModeDrawElementsIBM :
  int array -> int array -> int -> 'a -> int -> int -> unit
external glMultiTexCoord1d : int -> float -> unit
  = "glstub_glMultiTexCoord1d" "glstub_glMultiTexCoord1d"
external glMultiTexCoord1dARB : int -> float -> unit
  = "glstub_glMultiTexCoord1dARB" "glstub_glMultiTexCoord1dARB"
external glMultiTexCoord1dv : int -> float array -> unit
  = "glstub_glMultiTexCoord1dv" "glstub_glMultiTexCoord1dv"
external glMultiTexCoord1dvARB : int -> float array -> unit
  = "glstub_glMultiTexCoord1dvARB" "glstub_glMultiTexCoord1dvARB"
external glMultiTexCoord1f : int -> float -> unit
  = "glstub_glMultiTexCoord1f" "glstub_glMultiTexCoord1f"
external glMultiTexCoord1fARB : int -> float -> unit
  = "glstub_glMultiTexCoord1fARB" "glstub_glMultiTexCoord1fARB"
val glMultiTexCoord1fv : int -> float array -> unit
val glMultiTexCoord1fvARB : int -> float array -> unit
external glMultiTexCoord1hNV : int -> int -> unit
  = "glstub_glMultiTexCoord1hNV" "glstub_glMultiTexCoord1hNV"
val glMultiTexCoord1hvNV : int -> int array -> unit
external glMultiTexCoord1i : int -> int -> unit = "glstub_glMultiTexCoord1i"
  "glstub_glMultiTexCoord1i"
external glMultiTexCoord1iARB : int -> int -> unit
  = "glstub_glMultiTexCoord1iARB" "glstub_glMultiTexCoord1iARB"
val glMultiTexCoord1iv : int -> int array -> unit
val glMultiTexCoord1ivARB : int -> int array -> unit
external glMultiTexCoord1s : int -> int -> unit = "glstub_glMultiTexCoord1s"
  "glstub_glMultiTexCoord1s"
external glMultiTexCoord1sARB : int -> int -> unit
  = "glstub_glMultiTexCoord1sARB" "glstub_glMultiTexCoord1sARB"
val glMultiTexCoord1sv : int -> int array -> unit
val glMultiTexCoord1svARB : int -> int array -> unit
external glMultiTexCoord2d : int -> float -> float -> unit
  = "glstub_glMultiTexCoord2d" "glstub_glMultiTexCoord2d"
external glMultiTexCoord2dARB : int -> float -> float -> unit
  = "glstub_glMultiTexCoord2dARB" "glstub_glMultiTexCoord2dARB"
external glMultiTexCoord2dv : int -> float array -> unit
  = "glstub_glMultiTexCoord2dv" "glstub_glMultiTexCoord2dv"
external glMultiTexCoord2dvARB : int -> float array -> unit
  = "glstub_glMultiTexCoord2dvARB" "glstub_glMultiTexCoord2dvARB"
external glMultiTexCoord2f : int -> float -> float -> unit
  = "glstub_glMultiTexCoord2f" "glstub_glMultiTexCoord2f"
external glMultiTexCoord2fARB : int -> float -> float -> unit
  = "glstub_glMultiTexCoord2fARB" "glstub_glMultiTexCoord2fARB"
val glMultiTexCoord2fv : int -> float array -> unit
val glMultiTexCoord2fvARB : int -> float array -> unit
external glMultiTexCoord2hNV : int -> int -> int -> unit
  = "glstub_glMultiTexCoord2hNV" "glstub_glMultiTexCoord2hNV"
val glMultiTexCoord2hvNV : int -> int array -> unit
external glMultiTexCoord2i : int -> int -> int -> unit
  = "glstub_glMultiTexCoord2i" "glstub_glMultiTexCoord2i"
external glMultiTexCoord2iARB : int -> int -> int -> unit
  = "glstub_glMultiTexCoord2iARB" "glstub_glMultiTexCoord2iARB"
val glMultiTexCoord2iv : int -> int array -> unit
val glMultiTexCoord2ivARB : int -> int array -> unit
external glMultiTexCoord2s : int -> int -> int -> unit
  = "glstub_glMultiTexCoord2s" "glstub_glMultiTexCoord2s"
external glMultiTexCoord2sARB : int -> int -> int -> unit
  = "glstub_glMultiTexCoord2sARB" "glstub_glMultiTexCoord2sARB"
val glMultiTexCoord2sv : int -> int array -> unit
val glMultiTexCoord2svARB : int -> int array -> unit
external glMultiTexCoord3d : int -> float -> float -> float -> unit
  = "glstub_glMultiTexCoord3d" "glstub_glMultiTexCoord3d"
external glMultiTexCoord3dARB : int -> float -> float -> float -> unit
  = "glstub_glMultiTexCoord3dARB" "glstub_glMultiTexCoord3dARB"
external glMultiTexCoord3dv : int -> float array -> unit
  = "glstub_glMultiTexCoord3dv" "glstub_glMultiTexCoord3dv"
external glMultiTexCoord3dvARB : int -> float array -> unit
  = "glstub_glMultiTexCoord3dvARB" "glstub_glMultiTexCoord3dvARB"
external glMultiTexCoord3f : int -> float -> float -> float -> unit
  = "glstub_glMultiTexCoord3f" "glstub_glMultiTexCoord3f"
external glMultiTexCoord3fARB : int -> float -> float -> float -> unit
  = "glstub_glMultiTexCoord3fARB" "glstub_glMultiTexCoord3fARB"
val glMultiTexCoord3fv : int -> float array -> unit
val glMultiTexCoord3fvARB : int -> float array -> unit
external glMultiTexCoord3hNV : int -> int -> int -> int -> unit
  = "glstub_glMultiTexCoord3hNV" "glstub_glMultiTexCoord3hNV"
val glMultiTexCoord3hvNV : int -> int array -> unit
external glMultiTexCoord3i : int -> int -> int -> int -> unit
  = "glstub_glMultiTexCoord3i" "glstub_glMultiTexCoord3i"
external glMultiTexCoord3iARB : int -> int -> int -> int -> unit
  = "glstub_glMultiTexCoord3iARB" "glstub_glMultiTexCoord3iARB"
val glMultiTexCoord3iv : int -> int array -> unit
val glMultiTexCoord3ivARB : int -> int array -> unit
external glMultiTexCoord3s : int -> int -> int -> int -> unit
  = "glstub_glMultiTexCoord3s" "glstub_glMultiTexCoord3s"
external glMultiTexCoord3sARB : int -> int -> int -> int -> unit
  = "glstub_glMultiTexCoord3sARB" "glstub_glMultiTexCoord3sARB"
val glMultiTexCoord3sv : int -> int array -> unit
val glMultiTexCoord3svARB : int -> int array -> unit
external glMultiTexCoord4d : int -> float -> float -> float -> float -> unit
  = "glstub_glMultiTexCoord4d" "glstub_glMultiTexCoord4d"
external glMultiTexCoord4dARB :
  int -> float -> float -> float -> float -> unit
  = "glstub_glMultiTexCoord4dARB" "glstub_glMultiTexCoord4dARB"
external glMultiTexCoord4dv : int -> float array -> unit
  = "glstub_glMultiTexCoord4dv" "glstub_glMultiTexCoord4dv"
external glMultiTexCoord4dvARB : int -> float array -> unit
  = "glstub_glMultiTexCoord4dvARB" "glstub_glMultiTexCoord4dvARB"
external glMultiTexCoord4f : int -> float -> float -> float -> float -> unit
  = "glstub_glMultiTexCoord4f" "glstub_glMultiTexCoord4f"
external glMultiTexCoord4fARB :
  int -> float -> float -> float -> float -> unit
  = "glstub_glMultiTexCoord4fARB" "glstub_glMultiTexCoord4fARB"
val glMultiTexCoord4fv : int -> float array -> unit
val glMultiTexCoord4fvARB : int -> float array -> unit
external glMultiTexCoord4hNV : int -> int -> int -> int -> int -> unit
  = "glstub_glMultiTexCoord4hNV" "glstub_glMultiTexCoord4hNV"
val glMultiTexCoord4hvNV : int -> int array -> unit
external glMultiTexCoord4i : int -> int -> int -> int -> int -> unit
  = "glstub_glMultiTexCoord4i" "glstub_glMultiTexCoord4i"
external glMultiTexCoord4iARB : int -> int -> int -> int -> int -> unit
  = "glstub_glMultiTexCoord4iARB" "glstub_glMultiTexCoord4iARB"
val glMultiTexCoord4iv : int -> int array -> unit
val glMultiTexCoord4ivARB : int -> int array -> unit
external glMultiTexCoord4s : int -> int -> int -> int -> int -> unit
  = "glstub_glMultiTexCoord4s" "glstub_glMultiTexCoord4s"
external glMultiTexCoord4sARB : int -> int -> int -> int -> int -> unit
  = "glstub_glMultiTexCoord4sARB" "glstub_glMultiTexCoord4sARB"
val glMultiTexCoord4sv : int -> int array -> unit
val glMultiTexCoord4svARB : int -> int array -> unit
external glNewBufferRegionEXT : int -> int = "glstub_glNewBufferRegionEXT"
  "glstub_glNewBufferRegionEXT"
external glNewList : int -> int -> unit = "glstub_glNewList"
  "glstub_glNewList"
external glNewObjectBufferATI : int -> 'a -> int -> int
  = "glstub_glNewObjectBufferATI" "glstub_glNewObjectBufferATI"
external glNormal3b : int -> int -> int -> unit = "glstub_glNormal3b"
  "glstub_glNormal3b"
val glNormal3bv : int array -> unit
external glNormal3d : float -> float -> float -> unit = "glstub_glNormal3d"
  "glstub_glNormal3d"
external glNormal3dv : float array -> unit = "glstub_glNormal3dv"
  "glstub_glNormal3dv"
external glNormal3f : float -> float -> float -> unit = "glstub_glNormal3f"
  "glstub_glNormal3f"
external glNormal3fVertex3fSUN :
  float -> float -> float -> float -> float -> float -> unit
  = "glstub_glNormal3fVertex3fSUN_byte" "glstub_glNormal3fVertex3fSUN"
val glNormal3fVertex3fvSUN : float array -> float array -> unit
val glNormal3fv : float array -> unit
external glNormal3hNV : int -> int -> int -> unit = "glstub_glNormal3hNV"
  "glstub_glNormal3hNV"
val glNormal3hvNV : int array -> unit
external glNormal3i : int -> int -> int -> unit = "glstub_glNormal3i"
  "glstub_glNormal3i"
val glNormal3iv : int array -> unit
external glNormal3s : int -> int -> int -> unit = "glstub_glNormal3s"
  "glstub_glNormal3s"
val glNormal3sv : int array -> unit
external glNormalPointer : int -> int -> 'a -> unit
  = "glstub_glNormalPointer" "glstub_glNormalPointer"
external glNormalPointerEXT : int -> int -> int -> 'a -> unit
  = "glstub_glNormalPointerEXT" "glstub_glNormalPointerEXT"
external glNormalPointerListIBM : int -> int -> 'a -> int -> unit
  = "glstub_glNormalPointerListIBM" "glstub_glNormalPointerListIBM"
external glNormalPointervINTEL : int -> 'a -> unit
  = "glstub_glNormalPointervINTEL" "glstub_glNormalPointervINTEL"
external glNormalStream3bATI : int -> int -> int -> int -> unit
  = "glstub_glNormalStream3bATI" "glstub_glNormalStream3bATI"
val glNormalStream3bvATI : int -> int array -> unit
external glNormalStream3dATI : int -> float -> float -> float -> unit
  = "glstub_glNormalStream3dATI" "glstub_glNormalStream3dATI"
external glNormalStream3dvATI : int -> float array -> unit
  = "glstub_glNormalStream3dvATI" "glstub_glNormalStream3dvATI"
external glNormalStream3fATI : int -> float -> float -> float -> unit
  = "glstub_glNormalStream3fATI" "glstub_glNormalStream3fATI"
val glNormalStream3fvATI : int -> float array -> unit
external glNormalStream3iATI : int -> int -> int -> int -> unit
  = "glstub_glNormalStream3iATI" "glstub_glNormalStream3iATI"
val glNormalStream3ivATI : int -> int array -> unit
external glNormalStream3sATI : int -> int -> int -> int -> unit
  = "glstub_glNormalStream3sATI" "glstub_glNormalStream3sATI"
val glNormalStream3svATI : int -> int array -> unit
external glOrtho : float -> float -> float -> float -> float -> float -> unit
  = "glstub_glOrtho_byte" "glstub_glOrtho"
external glOrthofOES :
  float -> float -> float -> float -> float -> float -> unit
  = "glstub_glOrthofOES_byte" "glstub_glOrthofOES"
external glPNTrianglesfATI : int -> float -> unit
  = "glstub_glPNTrianglesfATI" "glstub_glPNTrianglesfATI"
external glPNTrianglesiATI : int -> int -> unit = "glstub_glPNTrianglesiATI"
  "glstub_glPNTrianglesiATI"
external glPassTexCoordATI : int -> int -> int -> unit
  = "glstub_glPassTexCoordATI" "glstub_glPassTexCoordATI"
external glPassThrough : float -> unit = "glstub_glPassThrough"
  "glstub_glPassThrough"
external glPixelDataRangeNV : int -> int -> 'a -> unit
  = "glstub_glPixelDataRangeNV" "glstub_glPixelDataRangeNV"
val glPixelMapfv : int -> int -> float array -> unit
val glPixelMapuiv : int -> int -> int array -> unit
val glPixelMapusv : int -> int -> int array -> unit
external glPixelStoref : int -> float -> unit = "glstub_glPixelStoref"
  "glstub_glPixelStoref"
external glPixelStorei : int -> int -> unit = "glstub_glPixelStorei"
  "glstub_glPixelStorei"
external glPixelTexGenSGIX : int -> unit = "glstub_glPixelTexGenSGIX"
  "glstub_glPixelTexGenSGIX"
external glPixelTransferf : int -> float -> unit = "glstub_glPixelTransferf"
  "glstub_glPixelTransferf"
external glPixelTransferi : int -> int -> unit = "glstub_glPixelTransferi"
  "glstub_glPixelTransferi"
external glPixelTransformParameterfEXT : int -> int -> float -> unit
  = "glstub_glPixelTransformParameterfEXT"
  "glstub_glPixelTransformParameterfEXT"
val glPixelTransformParameterfvEXT : int -> int -> float array -> unit
external glPixelTransformParameteriEXT : int -> int -> int -> unit
  = "glstub_glPixelTransformParameteriEXT"
  "glstub_glPixelTransformParameteriEXT"
val glPixelTransformParameterivEXT : int -> int -> int array -> unit
external glPixelZoom : float -> float -> unit = "glstub_glPixelZoom"
  "glstub_glPixelZoom"
external glPointParameterf : int -> float -> unit
  = "glstub_glPointParameterf" "glstub_glPointParameterf"
external glPointParameterfARB : int -> float -> unit
  = "glstub_glPointParameterfARB" "glstub_glPointParameterfARB"
external glPointParameterfEXT : int -> float -> unit
  = "glstub_glPointParameterfEXT" "glstub_glPointParameterfEXT"
val glPointParameterfv : int -> float array -> unit
val glPointParameterfvARB : int -> float array -> unit
val glPointParameterfvEXT : int -> float array -> unit
external glPointParameteriNV : int -> int -> unit
  = "glstub_glPointParameteriNV" "glstub_glPointParameteriNV"
val glPointParameterivNV : int -> int array -> unit
external glPointSize : float -> unit = "glstub_glPointSize"
  "glstub_glPointSize"
val glPollAsyncSGIX : int array -> int
external glPolygonMode : int -> int -> unit = "glstub_glPolygonMode"
  "glstub_glPolygonMode"
external glPolygonOffset : float -> float -> unit = "glstub_glPolygonOffset"
  "glstub_glPolygonOffset"
external glPolygonOffsetEXT : float -> float -> unit
  = "glstub_glPolygonOffsetEXT" "glstub_glPolygonOffsetEXT"
val glPolygonStipple : int array -> unit
external glPopAttrib : unit -> unit = "glstub_glPopAttrib"
  "glstub_glPopAttrib"
external glPopClientAttrib : unit -> unit = "glstub_glPopClientAttrib"
  "glstub_glPopClientAttrib"
external glPopMatrix : unit -> unit = "glstub_glPopMatrix"
  "glstub_glPopMatrix"
external glPopName : unit -> unit = "glstub_glPopName" "glstub_glPopName"
external glPrimitiveRestartIndexNV : int -> unit
  = "glstub_glPrimitiveRestartIndexNV" "glstub_glPrimitiveRestartIndexNV"
external glPrimitiveRestartNV : unit -> unit = "glstub_glPrimitiveRestartNV"
  "glstub_glPrimitiveRestartNV"
val glPrioritizeTextures : int -> int array -> float array -> unit
val glPrioritizeTexturesEXT : int -> int array -> float array -> unit
val glProgramBufferParametersIivNV :
  int -> int -> int -> int -> int array -> unit
val glProgramBufferParametersIuivNV :
  int -> int -> int -> int -> int array -> unit
val glProgramBufferParametersfvNV :
  int -> int -> int -> int -> float array -> unit
external glProgramEnvParameter4dARB :
  int -> int -> float -> float -> float -> float -> unit
  = "glstub_glProgramEnvParameter4dARB_byte"
  "glstub_glProgramEnvParameter4dARB"
external glProgramEnvParameter4dvARB : int -> int -> float array -> unit
  = "glstub_glProgramEnvParameter4dvARB" "glstub_glProgramEnvParameter4dvARB"
external glProgramEnvParameter4fARB :
  int -> int -> float -> float -> float -> float -> unit
  = "glstub_glProgramEnvParameter4fARB_byte"
  "glstub_glProgramEnvParameter4fARB"
val glProgramEnvParameter4fvARB : int -> int -> float array -> unit
external glProgramEnvParameterI4iNV :
  int -> int -> int -> int -> int -> int -> unit
  = "glstub_glProgramEnvParameterI4iNV_byte"
  "glstub_glProgramEnvParameterI4iNV"
val glProgramEnvParameterI4ivNV : int -> int -> int array -> unit
external glProgramEnvParameterI4uiNV :
  int -> int -> int -> int -> int -> int -> unit
  = "glstub_glProgramEnvParameterI4uiNV_byte"
  "glstub_glProgramEnvParameterI4uiNV"
val glProgramEnvParameterI4uivNV : int -> int -> int array -> unit
val glProgramEnvParameters4fvEXT : int -> int -> int -> float array -> unit
val glProgramEnvParametersI4ivNV : int -> int -> int -> int array -> unit
val glProgramEnvParametersI4uivNV : int -> int -> int -> int array -> unit
external glProgramLocalParameter4dARB :
  int -> int -> float -> float -> float -> float -> unit
  = "glstub_glProgramLocalParameter4dARB_byte"
  "glstub_glProgramLocalParameter4dARB"
external glProgramLocalParameter4dvARB : int -> int -> float array -> unit
  = "glstub_glProgramLocalParameter4dvARB"
  "glstub_glProgramLocalParameter4dvARB"
external glProgramLocalParameter4fARB :
  int -> int -> float -> float -> float -> float -> unit
  = "glstub_glProgramLocalParameter4fARB_byte"
  "glstub_glProgramLocalParameter4fARB"
val glProgramLocalParameter4fvARB : int -> int -> float array -> unit
external glProgramLocalParameterI4iNV :
  int -> int -> int -> int -> int -> int -> unit
  = "glstub_glProgramLocalParameterI4iNV_byte"
  "glstub_glProgramLocalParameterI4iNV"
val glProgramLocalParameterI4ivNV : int -> int -> int array -> unit
external glProgramLocalParameterI4uiNV :
  int -> int -> int -> int -> int -> int -> unit
  = "glstub_glProgramLocalParameterI4uiNV_byte"
  "glstub_glProgramLocalParameterI4uiNV"
val glProgramLocalParameterI4uivNV : int -> int -> int array -> unit
val glProgramLocalParameters4fvEXT : int -> int -> int -> float array -> unit
val glProgramLocalParametersI4ivNV : int -> int -> int -> int array -> unit
val glProgramLocalParametersI4uivNV : int -> int -> int -> int array -> unit
val glProgramNamedParameter4dNV :
  int -> int -> int array -> float -> float -> float -> float -> unit
val glProgramNamedParameter4dvNV :
  int -> int -> int array -> float array -> unit
val glProgramNamedParameter4fNV :
  int -> int -> int array -> float -> float -> float -> float -> unit
val glProgramNamedParameter4fvNV :
  int -> int -> int array -> float array -> unit
external glProgramParameter4dNV :
  int -> int -> float -> float -> float -> float -> unit
  = "glstub_glProgramParameter4dNV_byte" "glstub_glProgramParameter4dNV"
external glProgramParameter4dvNV : int -> int -> float array -> unit
  = "glstub_glProgramParameter4dvNV" "glstub_glProgramParameter4dvNV"
external glProgramParameter4fNV :
  int -> int -> float -> float -> float -> float -> unit
  = "glstub_glProgramParameter4fNV_byte" "glstub_glProgramParameter4fNV"
val glProgramParameter4fvNV : int -> int -> float array -> unit
external glProgramParameteriEXT : int -> int -> int -> unit
  = "glstub_glProgramParameteriEXT" "glstub_glProgramParameteriEXT"
external glProgramParameters4dvNV : int -> int -> int -> float array -> unit
  = "glstub_glProgramParameters4dvNV" "glstub_glProgramParameters4dvNV"
val glProgramParameters4fvNV : int -> int -> int -> float array -> unit
external glProgramStringARB : int -> int -> int -> 'a -> unit
  = "glstub_glProgramStringARB" "glstub_glProgramStringARB"
external glProgramVertexLimitNV : int -> int -> unit
  = "glstub_glProgramVertexLimitNV" "glstub_glProgramVertexLimitNV"
external glPushAttrib : int -> unit = "glstub_glPushAttrib"
  "glstub_glPushAttrib"
external glPushClientAttrib : int -> unit = "glstub_glPushClientAttrib"
  "glstub_glPushClientAttrib"
external glPushMatrix : unit -> unit = "glstub_glPushMatrix"
  "glstub_glPushMatrix"
external glPushName : int -> unit = "glstub_glPushName" "glstub_glPushName"
external glRasterPos2d : float -> float -> unit = "glstub_glRasterPos2d"
  "glstub_glRasterPos2d"
external glRasterPos2dv : float array -> unit = "glstub_glRasterPos2dv"
  "glstub_glRasterPos2dv"
external glRasterPos2f : float -> float -> unit = "glstub_glRasterPos2f"
  "glstub_glRasterPos2f"
val glRasterPos2fv : float array -> unit
external glRasterPos2i : int -> int -> unit = "glstub_glRasterPos2i"
  "glstub_glRasterPos2i"
val glRasterPos2iv : int array -> unit
external glRasterPos2s : int -> int -> unit = "glstub_glRasterPos2s"
  "glstub_glRasterPos2s"
val glRasterPos2sv : int array -> unit
external glRasterPos3d : float -> float -> float -> unit
  = "glstub_glRasterPos3d" "glstub_glRasterPos3d"
external glRasterPos3dv : float array -> unit = "glstub_glRasterPos3dv"
  "glstub_glRasterPos3dv"
external glRasterPos3f : float -> float -> float -> unit
  = "glstub_glRasterPos3f" "glstub_glRasterPos3f"
val glRasterPos3fv : float array -> unit
external glRasterPos3i : int -> int -> int -> unit = "glstub_glRasterPos3i"
  "glstub_glRasterPos3i"
val glRasterPos3iv : int array -> unit
external glRasterPos3s : int -> int -> int -> unit = "glstub_glRasterPos3s"
  "glstub_glRasterPos3s"
val glRasterPos3sv : int array -> unit
external glRasterPos4d : float -> float -> float -> float -> unit
  = "glstub_glRasterPos4d" "glstub_glRasterPos4d"
external glRasterPos4dv : float array -> unit = "glstub_glRasterPos4dv"
  "glstub_glRasterPos4dv"
external glRasterPos4f : float -> float -> float -> float -> unit
  = "glstub_glRasterPos4f" "glstub_glRasterPos4f"
val glRasterPos4fv : float array -> unit
external glRasterPos4i : int -> int -> int -> int -> unit
  = "glstub_glRasterPos4i" "glstub_glRasterPos4i"
val glRasterPos4iv : int array -> unit
external glRasterPos4s : int -> int -> int -> int -> unit
  = "glstub_glRasterPos4s" "glstub_glRasterPos4s"
val glRasterPos4sv : int array -> unit
external glReadBuffer : int -> unit = "glstub_glReadBuffer"
  "glstub_glReadBuffer"
external glReadBufferRegionEXT : int -> int -> int -> int -> int -> unit
  = "glstub_glReadBufferRegionEXT" "glstub_glReadBufferRegionEXT"
external glReadPixels : int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glReadPixels_byte" "glstub_glReadPixels"
external glReadVideoPixelsSUN :
  int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glReadVideoPixelsSUN_byte" "glstub_glReadVideoPixelsSUN"
external glRectd : float -> float -> float -> float -> unit
  = "glstub_glRectd" "glstub_glRectd"
external glRectdv : float array -> float array -> unit = "glstub_glRectdv"
  "glstub_glRectdv"
external glRectf : float -> float -> float -> float -> unit
  = "glstub_glRectf" "glstub_glRectf"
val glRectfv : float array -> float array -> unit
external glRecti : int -> int -> int -> int -> unit = "glstub_glRecti"
  "glstub_glRecti"
val glRectiv : int array -> int array -> unit
external glRects : int -> int -> int -> int -> unit = "glstub_glRects"
  "glstub_glRects"
val glRectsv : int array -> int array -> unit
external glReferencePlaneSGIX : float array -> unit
  = "glstub_glReferencePlaneSGIX" "glstub_glReferencePlaneSGIX"
external glRenderMode : int -> int = "glstub_glRenderMode"
  "glstub_glRenderMode"
external glRenderbufferStorageEXT : int -> int -> int -> int -> unit
  = "glstub_glRenderbufferStorageEXT" "glstub_glRenderbufferStorageEXT"
external glRenderbufferStorageMultisampleCoverageNV :
  int -> int -> int -> int -> int -> int -> unit
  = "glstub_glRenderbufferStorageMultisampleCoverageNV_byte"
  "glstub_glRenderbufferStorageMultisampleCoverageNV"
external glRenderbufferStorageMultisampleEXT :
  int -> int -> int -> int -> int -> unit
  = "glstub_glRenderbufferStorageMultisampleEXT"
  "glstub_glRenderbufferStorageMultisampleEXT"
external glReplacementCodePointerSUN : int -> int -> 'a -> unit
  = "glstub_glReplacementCodePointerSUN" "glstub_glReplacementCodePointerSUN"
external glReplacementCodeubSUN : int -> unit
  = "glstub_glReplacementCodeubSUN" "glstub_glReplacementCodeubSUN"
val glReplacementCodeubvSUN : int array -> unit
external glReplacementCodeuiColor3fVertex3fSUN :
  int -> float -> float -> float -> float -> float -> float -> unit
  = "glstub_glReplacementCodeuiColor3fVertex3fSUN_byte"
  "glstub_glReplacementCodeuiColor3fVertex3fSUN"
val glReplacementCodeuiColor3fVertex3fvSUN :
  int array -> float array -> float array -> unit
external glReplacementCodeuiColor4fNormal3fVertex3fSUN :
  int ->
  float ->
  float ->
  float ->
  float -> float -> float -> float -> float -> float -> float -> unit
  = "glstub_glReplacementCodeuiColor4fNormal3fVertex3fSUN_byte"
  "glstub_glReplacementCodeuiColor4fNormal3fVertex3fSUN"
val glReplacementCodeuiColor4fNormal3fVertex3fvSUN :
  int array -> float array -> float array -> float array -> unit
external glReplacementCodeuiColor4ubVertex3fSUN :
  int -> int -> int -> int -> int -> float -> float -> float -> unit
  = "glstub_glReplacementCodeuiColor4ubVertex3fSUN_byte"
  "glstub_glReplacementCodeuiColor4ubVertex3fSUN"
val glReplacementCodeuiColor4ubVertex3fvSUN :
  int array -> int array -> float array -> unit
external glReplacementCodeuiNormal3fVertex3fSUN :
  int -> float -> float -> float -> float -> float -> float -> unit
  = "glstub_glReplacementCodeuiNormal3fVertex3fSUN_byte"
  "glstub_glReplacementCodeuiNormal3fVertex3fSUN"
val glReplacementCodeuiNormal3fVertex3fvSUN :
  int array -> float array -> float array -> unit
external glReplacementCodeuiSUN : int -> unit
  = "glstub_glReplacementCodeuiSUN" "glstub_glReplacementCodeuiSUN"
external glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN :
  int ->
  float ->
  float ->
  float ->
  float ->
  float ->
  float -> float -> float -> float -> float -> float -> float -> unit
  = "glstub_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN_byte"
  "glstub_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN"
val glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN :
  int array ->
  float array -> float array -> float array -> float array -> unit
external glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN :
  int ->
  float ->
  float -> float -> float -> float -> float -> float -> float -> unit
  = "glstub_glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN_byte"
  "glstub_glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN"
val glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN :
  int array -> float array -> float array -> float array -> unit
external glReplacementCodeuiTexCoord2fVertex3fSUN :
  int -> float -> float -> float -> float -> float -> unit
  = "glstub_glReplacementCodeuiTexCoord2fVertex3fSUN_byte"
  "glstub_glReplacementCodeuiTexCoord2fVertex3fSUN"
val glReplacementCodeuiTexCoord2fVertex3fvSUN :
  int array -> float array -> float array -> unit
external glReplacementCodeuiVertex3fSUN :
  int -> float -> float -> float -> unit
  = "glstub_glReplacementCodeuiVertex3fSUN"
  "glstub_glReplacementCodeuiVertex3fSUN"
val glReplacementCodeuiVertex3fvSUN : int array -> float array -> unit
val glReplacementCodeuivSUN : int array -> unit
external glReplacementCodeusSUN : int -> unit
  = "glstub_glReplacementCodeusSUN" "glstub_glReplacementCodeusSUN"
val glReplacementCodeusvSUN : int array -> unit
val glRequestResidentProgramsNV : int -> int array -> unit
external glResetHistogram : int -> unit = "glstub_glResetHistogram"
  "glstub_glResetHistogram"
external glResetHistogramEXT : int -> unit = "glstub_glResetHistogramEXT"
  "glstub_glResetHistogramEXT"
external glResetMinmax : int -> unit = "glstub_glResetMinmax"
  "glstub_glResetMinmax"
external glResetMinmaxEXT : int -> unit = "glstub_glResetMinmaxEXT"
  "glstub_glResetMinmaxEXT"
external glResizeBuffersMESA : unit -> unit = "glstub_glResizeBuffersMESA"
  "glstub_glResizeBuffersMESA"
external glRotated : float -> float -> float -> float -> unit
  = "glstub_glRotated" "glstub_glRotated"
external glRotatef : float -> float -> float -> float -> unit
  = "glstub_glRotatef" "glstub_glRotatef"
external glSampleCoverage : float -> bool -> unit = "glstub_glSampleCoverage"
  "glstub_glSampleCoverage"
external glSampleCoverageARB : float -> bool -> unit
  = "glstub_glSampleCoverageARB" "glstub_glSampleCoverageARB"
external glSampleMapATI : int -> int -> int -> unit = "glstub_glSampleMapATI"
  "glstub_glSampleMapATI"
external glSampleMaskEXT : float -> bool -> unit = "glstub_glSampleMaskEXT"
  "glstub_glSampleMaskEXT"
external glSampleMaskSGIS : float -> bool -> unit = "glstub_glSampleMaskSGIS"
  "glstub_glSampleMaskSGIS"
external glSamplePatternEXT : int -> unit = "glstub_glSamplePatternEXT"
  "glstub_glSamplePatternEXT"
external glSamplePatternSGIS : int -> unit = "glstub_glSamplePatternSGIS"
  "glstub_glSamplePatternSGIS"
external glScaled : float -> float -> float -> unit = "glstub_glScaled"
  "glstub_glScaled"
external glScalef : float -> float -> float -> unit = "glstub_glScalef"
  "glstub_glScalef"
external glScissor : int -> int -> int -> int -> unit = "glstub_glScissor"
  "glstub_glScissor"
external glSecondaryColor3b : int -> int -> int -> unit
  = "glstub_glSecondaryColor3b" "glstub_glSecondaryColor3b"
external glSecondaryColor3bEXT : int -> int -> int -> unit
  = "glstub_glSecondaryColor3bEXT" "glstub_glSecondaryColor3bEXT"
val glSecondaryColor3bv : int array -> unit
val glSecondaryColor3bvEXT : int array -> unit
external glSecondaryColor3d : float -> float -> float -> unit
  = "glstub_glSecondaryColor3d" "glstub_glSecondaryColor3d"
external glSecondaryColor3dEXT : float -> float -> float -> unit
  = "glstub_glSecondaryColor3dEXT" "glstub_glSecondaryColor3dEXT"
external glSecondaryColor3dv : float array -> unit
  = "glstub_glSecondaryColor3dv" "glstub_glSecondaryColor3dv"
external glSecondaryColor3dvEXT : float array -> unit
  = "glstub_glSecondaryColor3dvEXT" "glstub_glSecondaryColor3dvEXT"
external glSecondaryColor3f : float -> float -> float -> unit
  = "glstub_glSecondaryColor3f" "glstub_glSecondaryColor3f"
external glSecondaryColor3fEXT : float -> float -> float -> unit
  = "glstub_glSecondaryColor3fEXT" "glstub_glSecondaryColor3fEXT"
val glSecondaryColor3fv : float array -> unit
val glSecondaryColor3fvEXT : float array -> unit
external glSecondaryColor3hNV : int -> int -> int -> unit
  = "glstub_glSecondaryColor3hNV" "glstub_glSecondaryColor3hNV"
val glSecondaryColor3hvNV : int array -> unit
external glSecondaryColor3i : int -> int -> int -> unit
  = "glstub_glSecondaryColor3i" "glstub_glSecondaryColor3i"
external glSecondaryColor3iEXT : int -> int -> int -> unit
  = "glstub_glSecondaryColor3iEXT" "glstub_glSecondaryColor3iEXT"
val glSecondaryColor3iv : int array -> unit
val glSecondaryColor3ivEXT : int array -> unit
external glSecondaryColor3s : int -> int -> int -> unit
  = "glstub_glSecondaryColor3s" "glstub_glSecondaryColor3s"
external glSecondaryColor3sEXT : int -> int -> int -> unit
  = "glstub_glSecondaryColor3sEXT" "glstub_glSecondaryColor3sEXT"
val glSecondaryColor3sv : int array -> unit
val glSecondaryColor3svEXT : int array -> unit
external glSecondaryColor3ub : int -> int -> int -> unit
  = "glstub_glSecondaryColor3ub" "glstub_glSecondaryColor3ub"
external glSecondaryColor3ubEXT : int -> int -> int -> unit
  = "glstub_glSecondaryColor3ubEXT" "glstub_glSecondaryColor3ubEXT"
val glSecondaryColor3ubv : int array -> unit
val glSecondaryColor3ubvEXT : int array -> unit
external glSecondaryColor3ui : int -> int -> int -> unit
  = "glstub_glSecondaryColor3ui" "glstub_glSecondaryColor3ui"
external glSecondaryColor3uiEXT : int -> int -> int -> unit
  = "glstub_glSecondaryColor3uiEXT" "glstub_glSecondaryColor3uiEXT"
val glSecondaryColor3uiv : int array -> unit
val glSecondaryColor3uivEXT : int array -> unit
external glSecondaryColor3us : int -> int -> int -> unit
  = "glstub_glSecondaryColor3us" "glstub_glSecondaryColor3us"
external glSecondaryColor3usEXT : int -> int -> int -> unit
  = "glstub_glSecondaryColor3usEXT" "glstub_glSecondaryColor3usEXT"
val glSecondaryColor3usv : int array -> unit
val glSecondaryColor3usvEXT : int array -> unit
external glSecondaryColorPointer : int -> int -> int -> 'a -> unit
  = "glstub_glSecondaryColorPointer" "glstub_glSecondaryColorPointer"
external glSecondaryColorPointerEXT : int -> int -> int -> 'a -> unit
  = "glstub_glSecondaryColorPointerEXT" "glstub_glSecondaryColorPointerEXT"
external glSecondaryColorPointerListIBM :
  int -> int -> int -> 'a -> int -> unit
  = "glstub_glSecondaryColorPointerListIBM"
  "glstub_glSecondaryColorPointerListIBM"
val glSelectBuffer : int -> int array -> unit
external glSeparableFilter2D :
  int -> int -> int -> int -> int -> int -> 'a -> 'a -> unit
  = "glstub_glSeparableFilter2D_byte" "glstub_glSeparableFilter2D"
external glSeparableFilter2DEXT :
  int -> int -> int -> int -> int -> int -> 'a -> 'a -> unit
  = "glstub_glSeparableFilter2DEXT_byte" "glstub_glSeparableFilter2DEXT"
external glSetFenceAPPLE : int -> unit = "glstub_glSetFenceAPPLE"
  "glstub_glSetFenceAPPLE"
external glSetFenceNV : int -> int -> unit = "glstub_glSetFenceNV"
  "glstub_glSetFenceNV"
val glSetFragmentShaderConstantATI : int -> float array -> unit
external glSetInvariantEXT : int -> int -> 'a -> unit
  = "glstub_glSetInvariantEXT" "glstub_glSetInvariantEXT"
external glSetLocalConstantEXT : int -> int -> 'a -> unit
  = "glstub_glSetLocalConstantEXT" "glstub_glSetLocalConstantEXT"
external glShadeModel : int -> unit = "glstub_glShadeModel"
  "glstub_glShadeModel"
external glShaderOp1EXT : int -> int -> int -> unit = "glstub_glShaderOp1EXT"
  "glstub_glShaderOp1EXT"
external glShaderOp2EXT : int -> int -> int -> int -> unit
  = "glstub_glShaderOp2EXT" "glstub_glShaderOp2EXT"
external glShaderOp3EXT : int -> int -> int -> int -> int -> unit
  = "glstub_glShaderOp3EXT" "glstub_glShaderOp3EXT"
val glShaderSource : int -> int -> string array -> int array -> unit
val glShaderSourceARB : int -> int -> string array -> int array -> unit
val glSharpenTexFuncSGIS : int -> int -> float array -> unit
external glSpriteParameterfSGIX : int -> float -> unit
  = "glstub_glSpriteParameterfSGIX" "glstub_glSpriteParameterfSGIX"
val glSpriteParameterfvSGIX : int -> float array -> unit
external glSpriteParameteriSGIX : int -> int -> unit
  = "glstub_glSpriteParameteriSGIX" "glstub_glSpriteParameteriSGIX"
val glSpriteParameterivSGIX : int -> int array -> unit
external glStencilFunc : int -> int -> int -> unit = "glstub_glStencilFunc"
  "glstub_glStencilFunc"
external glStencilFuncSeparate : int -> int -> int -> int -> unit
  = "glstub_glStencilFuncSeparate" "glstub_glStencilFuncSeparate"
external glStencilFuncSeparateATI : int -> int -> int -> int -> unit
  = "glstub_glStencilFuncSeparateATI" "glstub_glStencilFuncSeparateATI"
external glStencilMask : int -> unit = "glstub_glStencilMask"
  "glstub_glStencilMask"
external glStencilMaskSeparate : int -> int -> unit
  = "glstub_glStencilMaskSeparate" "glstub_glStencilMaskSeparate"
external glStencilOp : int -> int -> int -> unit = "glstub_glStencilOp"
  "glstub_glStencilOp"
external glStencilOpSeparate : int -> int -> int -> int -> unit
  = "glstub_glStencilOpSeparate" "glstub_glStencilOpSeparate"
external glStencilOpSeparateATI : int -> int -> int -> int -> unit
  = "glstub_glStencilOpSeparateATI" "glstub_glStencilOpSeparateATI"
external glStringMarkerGREMEDY : int -> 'a -> unit
  = "glstub_glStringMarkerGREMEDY" "glstub_glStringMarkerGREMEDY"
external glSwizzleEXT : int -> int -> int -> int -> int -> int -> unit
  = "glstub_glSwizzleEXT_byte" "glstub_glSwizzleEXT"
external glTagSampleBufferSGIX : unit -> unit
  = "glstub_glTagSampleBufferSGIX" "glstub_glTagSampleBufferSGIX"
external glTangentPointerEXT : int -> int -> 'a -> unit
  = "glstub_glTangentPointerEXT" "glstub_glTangentPointerEXT"
external glTbufferMask3DFX : int -> unit = "glstub_glTbufferMask3DFX"
  "glstub_glTbufferMask3DFX"
external glTestFenceAPPLE : int -> bool = "glstub_glTestFenceAPPLE"
  "glstub_glTestFenceAPPLE"
external glTestFenceNV : int -> bool = "glstub_glTestFenceNV"
  "glstub_glTestFenceNV"
external glTestObjectAPPLE : int -> int -> bool = "glstub_glTestObjectAPPLE"
  "glstub_glTestObjectAPPLE"
external glTexBufferEXT : int -> int -> int -> unit = "glstub_glTexBufferEXT"
  "glstub_glTexBufferEXT"
val glTexBumpParameterfvATI : int -> float array -> unit
val glTexBumpParameterivATI : int -> int array -> unit
external glTexCoord1d : float -> unit = "glstub_glTexCoord1d"
  "glstub_glTexCoord1d"
external glTexCoord1dv : float array -> unit = "glstub_glTexCoord1dv"
  "glstub_glTexCoord1dv"
external glTexCoord1f : float -> unit = "glstub_glTexCoord1f"
  "glstub_glTexCoord1f"
val glTexCoord1fv : float array -> unit
external glTexCoord1hNV : int -> unit = "glstub_glTexCoord1hNV"
  "glstub_glTexCoord1hNV"
val glTexCoord1hvNV : int array -> unit
external glTexCoord1i : int -> unit = "glstub_glTexCoord1i"
  "glstub_glTexCoord1i"
val glTexCoord1iv : int array -> unit
external glTexCoord1s : int -> unit = "glstub_glTexCoord1s"
  "glstub_glTexCoord1s"
val glTexCoord1sv : int array -> unit
external glTexCoord2d : float -> float -> unit = "glstub_glTexCoord2d"
  "glstub_glTexCoord2d"
external glTexCoord2dv : float array -> unit = "glstub_glTexCoord2dv"
  "glstub_glTexCoord2dv"
external glTexCoord2f : float -> float -> unit = "glstub_glTexCoord2f"
  "glstub_glTexCoord2f"
external glTexCoord2fColor3fVertex3fSUN :
  float ->
  float -> float -> float -> float -> float -> float -> float -> unit
  = "glstub_glTexCoord2fColor3fVertex3fSUN_byte"
  "glstub_glTexCoord2fColor3fVertex3fSUN"
val glTexCoord2fColor3fVertex3fvSUN :
  float array -> float array -> float array -> unit
external glTexCoord2fColor4fNormal3fVertex3fSUN :
  float ->
  float ->
  float ->
  float ->
  float ->
  float -> float -> float -> float -> float -> float -> float -> unit
  = "glstub_glTexCoord2fColor4fNormal3fVertex3fSUN_byte"
  "glstub_glTexCoord2fColor4fNormal3fVertex3fSUN"
val glTexCoord2fColor4fNormal3fVertex3fvSUN :
  float array -> float array -> float array -> float array -> unit
external glTexCoord2fColor4ubVertex3fSUN :
  float ->
  float -> int -> int -> int -> int -> float -> float -> float -> unit
  = "glstub_glTexCoord2fColor4ubVertex3fSUN_byte"
  "glstub_glTexCoord2fColor4ubVertex3fSUN"
val glTexCoord2fColor4ubVertex3fvSUN :
  float array -> int array -> float array -> unit
external glTexCoord2fNormal3fVertex3fSUN :
  float ->
  float -> float -> float -> float -> float -> float -> float -> unit
  = "glstub_glTexCoord2fNormal3fVertex3fSUN_byte"
  "glstub_glTexCoord2fNormal3fVertex3fSUN"
val glTexCoord2fNormal3fVertex3fvSUN :
  float array -> float array -> float array -> unit
external glTexCoord2fVertex3fSUN :
  float -> float -> float -> float -> float -> unit
  = "glstub_glTexCoord2fVertex3fSUN" "glstub_glTexCoord2fVertex3fSUN"
val glTexCoord2fVertex3fvSUN : float array -> float array -> unit
val glTexCoord2fv : float array -> unit
external glTexCoord2hNV : int -> int -> unit = "glstub_glTexCoord2hNV"
  "glstub_glTexCoord2hNV"
val glTexCoord2hvNV : int array -> unit
external glTexCoord2i : int -> int -> unit = "glstub_glTexCoord2i"
  "glstub_glTexCoord2i"
val glTexCoord2iv : int array -> unit
external glTexCoord2s : int -> int -> unit = "glstub_glTexCoord2s"
  "glstub_glTexCoord2s"
val glTexCoord2sv : int array -> unit
external glTexCoord3d : float -> float -> float -> unit
  = "glstub_glTexCoord3d" "glstub_glTexCoord3d"
external glTexCoord3dv : float array -> unit = "glstub_glTexCoord3dv"
  "glstub_glTexCoord3dv"
external glTexCoord3f : float -> float -> float -> unit
  = "glstub_glTexCoord3f" "glstub_glTexCoord3f"
val glTexCoord3fv : float array -> unit
external glTexCoord3hNV : int -> int -> int -> unit = "glstub_glTexCoord3hNV"
  "glstub_glTexCoord3hNV"
val glTexCoord3hvNV : int array -> unit
external glTexCoord3i : int -> int -> int -> unit = "glstub_glTexCoord3i"
  "glstub_glTexCoord3i"
val glTexCoord3iv : int array -> unit
external glTexCoord3s : int -> int -> int -> unit = "glstub_glTexCoord3s"
  "glstub_glTexCoord3s"
val glTexCoord3sv : int array -> unit
external glTexCoord4d : float -> float -> float -> float -> unit
  = "glstub_glTexCoord4d" "glstub_glTexCoord4d"
external glTexCoord4dv : float array -> unit = "glstub_glTexCoord4dv"
  "glstub_glTexCoord4dv"
external glTexCoord4f : float -> float -> float -> float -> unit
  = "glstub_glTexCoord4f" "glstub_glTexCoord4f"
external glTexCoord4fColor4fNormal3fVertex4fSUN :
  float ->
  float ->
  float ->
  float ->
  float ->
  float ->
  float ->
  float ->
  float -> float -> float -> float -> float -> float -> float -> unit
  = "glstub_glTexCoord4fColor4fNormal3fVertex4fSUN_byte"
  "glstub_glTexCoord4fColor4fNormal3fVertex4fSUN"
val glTexCoord4fColor4fNormal3fVertex4fvSUN :
  float array -> float array -> float array -> float array -> unit
external glTexCoord4fVertex4fSUN :
  float ->
  float -> float -> float -> float -> float -> float -> float -> unit
  = "glstub_glTexCoord4fVertex4fSUN_byte" "glstub_glTexCoord4fVertex4fSUN"
val glTexCoord4fVertex4fvSUN : float array -> float array -> unit
val glTexCoord4fv : float array -> unit
external glTexCoord4hNV : int -> int -> int -> int -> unit
  = "glstub_glTexCoord4hNV" "glstub_glTexCoord4hNV"
val glTexCoord4hvNV : int array -> unit
external glTexCoord4i : int -> int -> int -> int -> unit
  = "glstub_glTexCoord4i" "glstub_glTexCoord4i"
val glTexCoord4iv : int array -> unit
external glTexCoord4s : int -> int -> int -> int -> unit
  = "glstub_glTexCoord4s" "glstub_glTexCoord4s"
val glTexCoord4sv : int array -> unit
external glTexCoordPointer : int -> int -> int -> 'a -> unit
  = "glstub_glTexCoordPointer" "glstub_glTexCoordPointer"
external glTexCoordPointerEXT : int -> int -> int -> int -> 'a -> unit
  = "glstub_glTexCoordPointerEXT" "glstub_glTexCoordPointerEXT"
external glTexCoordPointerListIBM : int -> int -> int -> 'a -> int -> unit
  = "glstub_glTexCoordPointerListIBM" "glstub_glTexCoordPointerListIBM"
external glTexCoordPointervINTEL : int -> int -> 'a -> unit
  = "glstub_glTexCoordPointervINTEL" "glstub_glTexCoordPointervINTEL"
external glTexEnvf : int -> int -> float -> unit = "glstub_glTexEnvf"
  "glstub_glTexEnvf"
val glTexEnvfv : int -> int -> float array -> unit
external glTexEnvi : int -> int -> int -> unit = "glstub_glTexEnvi"
  "glstub_glTexEnvi"
val glTexEnviv : int -> int -> int array -> unit
val glTexFilterFuncSGIS : int -> int -> int -> float array -> unit
external glTexGend : int -> int -> float -> unit = "glstub_glTexGend"
  "glstub_glTexGend"
external glTexGendv : int -> int -> float array -> unit = "glstub_glTexGendv"
  "glstub_glTexGendv"
external glTexGenf : int -> int -> float -> unit = "glstub_glTexGenf"
  "glstub_glTexGenf"
val glTexGenfv : int -> int -> float array -> unit
external glTexGeni : int -> int -> int -> unit = "glstub_glTexGeni"
  "glstub_glTexGeni"
val glTexGeniv : int -> int -> int array -> unit
external glTexImage1D :
  int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glTexImage1D_byte" "glstub_glTexImage1D"
external glTexImage2D :
  int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glTexImage2D_byte" "glstub_glTexImage2D"
external glTexImage3D :
  int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glTexImage3D_byte" "glstub_glTexImage3D"
external glTexImage3DEXT :
  int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glTexImage3DEXT_byte" "glstub_glTexImage3DEXT"
external glTexImage4DSGIS :
  int ->
  int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glTexImage4DSGIS_byte" "glstub_glTexImage4DSGIS"
val glTexParameterIivEXT : int -> int -> int array -> unit
val glTexParameterIuivEXT : int -> int -> int array -> unit
external glTexParameterf : int -> int -> float -> unit
  = "glstub_glTexParameterf" "glstub_glTexParameterf"
val glTexParameterfv : int -> int -> float array -> unit
external glTexParameteri : int -> int -> int -> unit
  = "glstub_glTexParameteri" "glstub_glTexParameteri"
val glTexParameteriv : int -> int -> int array -> unit
external glTexScissorFuncINTEL : int -> int -> int -> unit
  = "glstub_glTexScissorFuncINTEL" "glstub_glTexScissorFuncINTEL"
external glTexScissorINTEL : int -> float -> float -> unit
  = "glstub_glTexScissorINTEL" "glstub_glTexScissorINTEL"
external glTexSubImage1D :
  int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glTexSubImage1D_byte" "glstub_glTexSubImage1D"
external glTexSubImage1DEXT :
  int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glTexSubImage1DEXT_byte" "glstub_glTexSubImage1DEXT"
external glTexSubImage2D :
  int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glTexSubImage2D_byte" "glstub_glTexSubImage2D"
external glTexSubImage2DEXT :
  int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glTexSubImage2DEXT_byte" "glstub_glTexSubImage2DEXT"
external glTexSubImage3D :
  int ->
  int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glTexSubImage3D_byte" "glstub_glTexSubImage3D"
external glTexSubImage3DEXT :
  int ->
  int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glTexSubImage3DEXT_byte" "glstub_glTexSubImage3DEXT"
external glTexSubImage4DSGIS :
  int ->
  int ->
  int ->
  int -> int -> int -> int -> int -> int -> int -> int -> int -> 'a -> unit
  = "glstub_glTexSubImage4DSGIS_byte" "glstub_glTexSubImage4DSGIS"
external glTextureFogSGIX : int -> unit = "glstub_glTextureFogSGIX"
  "glstub_glTextureFogSGIX"
external glTextureLightEXT : int -> unit = "glstub_glTextureLightEXT"
  "glstub_glTextureLightEXT"
external glTextureMaterialEXT : int -> int -> unit
  = "glstub_glTextureMaterialEXT" "glstub_glTextureMaterialEXT"
external glTextureNormalEXT : int -> unit = "glstub_glTextureNormalEXT"
  "glstub_glTextureNormalEXT"
external glTextureRangeAPPLE : int -> int -> 'a -> unit
  = "glstub_glTextureRangeAPPLE" "glstub_glTextureRangeAPPLE"
external glTrackMatrixNV : int -> int -> int -> int -> unit
  = "glstub_glTrackMatrixNV" "glstub_glTrackMatrixNV"
val glTransformFeedbackAttribsNV : int -> int array -> int -> unit
val glTransformFeedbackVaryingsNV : int -> int -> int array -> int -> unit
external glTranslated : float -> float -> float -> unit
  = "glstub_glTranslated" "glstub_glTranslated"
external glTranslatef : float -> float -> float -> unit
  = "glstub_glTranslatef" "glstub_glTranslatef"
external glUniform1f : int -> float -> unit = "glstub_glUniform1f"
  "glstub_glUniform1f"
external glUniform1fARB : int -> float -> unit = "glstub_glUniform1fARB"
  "glstub_glUniform1fARB"
val glUniform1fv : int -> int -> float array -> unit
val glUniform1fvARB : int -> int -> float array -> unit
external glUniform1i : int -> int -> unit = "glstub_glUniform1i"
  "glstub_glUniform1i"
external glUniform1iARB : int -> int -> unit = "glstub_glUniform1iARB"
  "glstub_glUniform1iARB"
val glUniform1iv : int -> int -> int array -> unit
val glUniform1ivARB : int -> int -> int array -> unit
external glUniform1uiEXT : int -> int -> unit = "glstub_glUniform1uiEXT"
  "glstub_glUniform1uiEXT"
val glUniform1uivEXT : int -> int -> int array -> unit
external glUniform2f : int -> float -> float -> unit = "glstub_glUniform2f"
  "glstub_glUniform2f"
external glUniform2fARB : int -> float -> float -> unit
  = "glstub_glUniform2fARB" "glstub_glUniform2fARB"
val glUniform2fv : int -> int -> float array -> unit
val glUniform2fvARB : int -> int -> float array -> unit
external glUniform2i : int -> int -> int -> unit = "glstub_glUniform2i"
  "glstub_glUniform2i"
external glUniform2iARB : int -> int -> int -> unit = "glstub_glUniform2iARB"
  "glstub_glUniform2iARB"
val glUniform2iv : int -> int -> int array -> unit
val glUniform2ivARB : int -> int -> int array -> unit
external glUniform2uiEXT : int -> int -> int -> unit
  = "glstub_glUniform2uiEXT" "glstub_glUniform2uiEXT"
val glUniform2uivEXT : int -> int -> int array -> unit
external glUniform3f : int -> float -> float -> float -> unit
  = "glstub_glUniform3f" "glstub_glUniform3f"
external glUniform3fARB : int -> float -> float -> float -> unit
  = "glstub_glUniform3fARB" "glstub_glUniform3fARB"
val glUniform3fv : int -> int -> float array -> unit
val glUniform3fvARB : int -> int -> float array -> unit
external glUniform3i : int -> int -> int -> int -> unit
  = "glstub_glUniform3i" "glstub_glUniform3i"
external glUniform3iARB : int -> int -> int -> int -> unit
  = "glstub_glUniform3iARB" "glstub_glUniform3iARB"
val glUniform3iv : int -> int -> int array -> unit
val glUniform3ivARB : int -> int -> int array -> unit
external glUniform3uiEXT : int -> int -> int -> int -> unit
  = "glstub_glUniform3uiEXT" "glstub_glUniform3uiEXT"
val glUniform3uivEXT : int -> int -> int array -> unit
external glUniform4f : int -> float -> float -> float -> float -> unit
  = "glstub_glUniform4f" "glstub_glUniform4f"
external glUniform4fARB : int -> float -> float -> float -> float -> unit
  = "glstub_glUniform4fARB" "glstub_glUniform4fARB"
val glUniform4fv : int -> int -> float array -> unit
val glUniform4fvARB : int -> int -> float array -> unit
external glUniform4i : int -> int -> int -> int -> int -> unit
  = "glstub_glUniform4i" "glstub_glUniform4i"
external glUniform4iARB : int -> int -> int -> int -> int -> unit
  = "glstub_glUniform4iARB" "glstub_glUniform4iARB"
val glUniform4iv : int -> int -> int array -> unit
val glUniform4ivARB : int -> int -> int array -> unit
external glUniform4uiEXT : int -> int -> int -> int -> int -> unit
  = "glstub_glUniform4uiEXT" "glstub_glUniform4uiEXT"
val glUniform4uivEXT : int -> int -> int array -> unit
external glUniformBufferEXT : int -> int -> int -> unit
  = "glstub_glUniformBufferEXT" "glstub_glUniformBufferEXT"
val glUniformMatrix2fv : int -> int -> bool -> float array -> unit
val glUniformMatrix2fvARB : int -> int -> bool -> float array -> unit
val glUniformMatrix2x3fv : int -> int -> bool -> float array -> unit
val glUniformMatrix2x4fv : int -> int -> bool -> float array -> unit
val glUniformMatrix3fv : int -> int -> bool -> float array -> unit
val glUniformMatrix3fvARB : int -> int -> bool -> float array -> unit
val glUniformMatrix3x2fv : int -> int -> bool -> float array -> unit
val glUniformMatrix3x4fv : int -> int -> bool -> float array -> unit
val glUniformMatrix4fv : int -> int -> bool -> float array -> unit
val glUniformMatrix4fvARB : int -> int -> bool -> float array -> unit
val glUniformMatrix4x2fv : int -> int -> bool -> float array -> unit
val glUniformMatrix4x3fv : int -> int -> bool -> float array -> unit
external glUnlockArraysEXT : unit -> unit = "glstub_glUnlockArraysEXT"
  "glstub_glUnlockArraysEXT"
external glUnmapBuffer : int -> bool = "glstub_glUnmapBuffer"
  "glstub_glUnmapBuffer"
external glUnmapBufferARB : int -> bool = "glstub_glUnmapBufferARB"
  "glstub_glUnmapBufferARB"
external glUnmapObjectBufferATI : int -> unit
  = "glstub_glUnmapObjectBufferATI" "glstub_glUnmapObjectBufferATI"
external glUpdateObjectBufferATI : int -> int -> int -> 'a -> int -> unit
  = "glstub_glUpdateObjectBufferATI" "glstub_glUpdateObjectBufferATI"
external glUseProgram : int -> unit = "glstub_glUseProgram"
  "glstub_glUseProgram"
external glUseProgramObjectARB : int -> unit = "glstub_glUseProgramObjectARB"
  "glstub_glUseProgramObjectARB"
external glValidateProgram : int -> unit = "glstub_glValidateProgram"
  "glstub_glValidateProgram"
external glValidateProgramARB : int -> unit = "glstub_glValidateProgramARB"
  "glstub_glValidateProgramARB"
external glVariantArrayObjectATI : int -> int -> int -> int -> int -> unit
  = "glstub_glVariantArrayObjectATI" "glstub_glVariantArrayObjectATI"
external glVariantPointerEXT : int -> int -> int -> 'a -> unit
  = "glstub_glVariantPointerEXT" "glstub_glVariantPointerEXT"
val glVariantbvEXT : int -> int array -> unit
external glVariantdvEXT : int -> float array -> unit
  = "glstub_glVariantdvEXT" "glstub_glVariantdvEXT"
val glVariantfvEXT : int -> float array -> unit
val glVariantivEXT : int -> int array -> unit
val glVariantsvEXT : int -> int array -> unit
val glVariantubvEXT : int -> int array -> unit
val glVariantuivEXT : int -> int array -> unit
val glVariantusvEXT : int -> int array -> unit
external glVertex2d : float -> float -> unit = "glstub_glVertex2d"
  "glstub_glVertex2d"
external glVertex2dv : float array -> unit = "glstub_glVertex2dv"
  "glstub_glVertex2dv"
external glVertex2f : float -> float -> unit = "glstub_glVertex2f"
  "glstub_glVertex2f"
val glVertex2fv : float array -> unit
external glVertex2hNV : int -> int -> unit = "glstub_glVertex2hNV"
  "glstub_glVertex2hNV"
val glVertex2hvNV : int array -> unit
external glVertex2i : int -> int -> unit = "glstub_glVertex2i"
  "glstub_glVertex2i"
val glVertex2iv : int array -> unit
external glVertex2s : int -> int -> unit = "glstub_glVertex2s"
  "glstub_glVertex2s"
val glVertex2sv : int array -> unit
external glVertex3d : float -> float -> float -> unit = "glstub_glVertex3d"
  "glstub_glVertex3d"
external glVertex3dv : float array -> unit = "glstub_glVertex3dv"
  "glstub_glVertex3dv"
external glVertex3f : float -> float -> float -> unit = "glstub_glVertex3f"
  "glstub_glVertex3f"
val glVertex3fv : float array -> unit
external glVertex3hNV : int -> int -> int -> unit = "glstub_glVertex3hNV"
  "glstub_glVertex3hNV"
val glVertex3hvNV : int array -> unit
external glVertex3i : int -> int -> int -> unit = "glstub_glVertex3i"
  "glstub_glVertex3i"
val glVertex3iv : int array -> unit
external glVertex3s : int -> int -> int -> unit = "glstub_glVertex3s"
  "glstub_glVertex3s"
val glVertex3sv : int array -> unit
external glVertex4d : float -> float -> float -> float -> unit
  = "glstub_glVertex4d" "glstub_glVertex4d"
external glVertex4dv : float array -> unit = "glstub_glVertex4dv"
  "glstub_glVertex4dv"
external glVertex4f : float -> float -> float -> float -> unit
  = "glstub_glVertex4f" "glstub_glVertex4f"
val glVertex4fv : float array -> unit
external glVertex4hNV : int -> int -> int -> int -> unit
  = "glstub_glVertex4hNV" "glstub_glVertex4hNV"
val glVertex4hvNV : int array -> unit
external glVertex4i : int -> int -> int -> int -> unit = "glstub_glVertex4i"
  "glstub_glVertex4i"
val glVertex4iv : int array -> unit
external glVertex4s : int -> int -> int -> int -> unit = "glstub_glVertex4s"
  "glstub_glVertex4s"
val glVertex4sv : int array -> unit
external glVertexArrayParameteriAPPLE : int -> int -> unit
  = "glstub_glVertexArrayParameteriAPPLE"
  "glstub_glVertexArrayParameteriAPPLE"
external glVertexArrayRangeAPPLE : int -> 'a -> unit
  = "glstub_glVertexArrayRangeAPPLE" "glstub_glVertexArrayRangeAPPLE"
external glVertexArrayRangeNV : int -> 'a -> unit
  = "glstub_glVertexArrayRangeNV" "glstub_glVertexArrayRangeNV"
external glVertexAttrib1d : int -> float -> unit = "glstub_glVertexAttrib1d"
  "glstub_glVertexAttrib1d"
external glVertexAttrib1dARB : int -> float -> unit
  = "glstub_glVertexAttrib1dARB" "glstub_glVertexAttrib1dARB"
external glVertexAttrib1dNV : int -> float -> unit
  = "glstub_glVertexAttrib1dNV" "glstub_glVertexAttrib1dNV"
external glVertexAttrib1dv : int -> float array -> unit
  = "glstub_glVertexAttrib1dv" "glstub_glVertexAttrib1dv"
external glVertexAttrib1dvARB : int -> float array -> unit
  = "glstub_glVertexAttrib1dvARB" "glstub_glVertexAttrib1dvARB"
external glVertexAttrib1dvNV : int -> float array -> unit
  = "glstub_glVertexAttrib1dvNV" "glstub_glVertexAttrib1dvNV"
external glVertexAttrib1f : int -> float -> unit = "glstub_glVertexAttrib1f"
  "glstub_glVertexAttrib1f"
external glVertexAttrib1fARB : int -> float -> unit
  = "glstub_glVertexAttrib1fARB" "glstub_glVertexAttrib1fARB"
external glVertexAttrib1fNV : int -> float -> unit
  = "glstub_glVertexAttrib1fNV" "glstub_glVertexAttrib1fNV"
val glVertexAttrib1fv : int -> float array -> unit
val glVertexAttrib1fvARB : int -> float array -> unit
val glVertexAttrib1fvNV : int -> float array -> unit
external glVertexAttrib1hNV : int -> int -> unit
  = "glstub_glVertexAttrib1hNV" "glstub_glVertexAttrib1hNV"
val glVertexAttrib1hvNV : int -> int array -> unit
external glVertexAttrib1s : int -> int -> unit = "glstub_glVertexAttrib1s"
  "glstub_glVertexAttrib1s"
external glVertexAttrib1sARB : int -> int -> unit
  = "glstub_glVertexAttrib1sARB" "glstub_glVertexAttrib1sARB"
external glVertexAttrib1sNV : int -> int -> unit
  = "glstub_glVertexAttrib1sNV" "glstub_glVertexAttrib1sNV"
val glVertexAttrib1sv : int -> int array -> unit
val glVertexAttrib1svARB : int -> int array -> unit
val glVertexAttrib1svNV : int -> int array -> unit
external glVertexAttrib2d : int -> float -> float -> unit
  = "glstub_glVertexAttrib2d" "glstub_glVertexAttrib2d"
external glVertexAttrib2dARB : int -> float -> float -> unit
  = "glstub_glVertexAttrib2dARB" "glstub_glVertexAttrib2dARB"
external glVertexAttrib2dNV : int -> float -> float -> unit
  = "glstub_glVertexAttrib2dNV" "glstub_glVertexAttrib2dNV"
external glVertexAttrib2dv : int -> float array -> unit
  = "glstub_glVertexAttrib2dv" "glstub_glVertexAttrib2dv"
external glVertexAttrib2dvARB : int -> float array -> unit
  = "glstub_glVertexAttrib2dvARB" "glstub_glVertexAttrib2dvARB"
external glVertexAttrib2dvNV : int -> float array -> unit
  = "glstub_glVertexAttrib2dvNV" "glstub_glVertexAttrib2dvNV"
external glVertexAttrib2f : int -> float -> float -> unit
  = "glstub_glVertexAttrib2f" "glstub_glVertexAttrib2f"
external glVertexAttrib2fARB : int -> float -> float -> unit
  = "glstub_glVertexAttrib2fARB" "glstub_glVertexAttrib2fARB"
external glVertexAttrib2fNV : int -> float -> float -> unit
  = "glstub_glVertexAttrib2fNV" "glstub_glVertexAttrib2fNV"
val glVertexAttrib2fv : int -> float array -> unit
val glVertexAttrib2fvARB : int -> float array -> unit
val glVertexAttrib2fvNV : int -> float array -> unit
external glVertexAttrib2hNV : int -> int -> int -> unit
  = "glstub_glVertexAttrib2hNV" "glstub_glVertexAttrib2hNV"
val glVertexAttrib2hvNV : int -> int array -> unit
external glVertexAttrib2s : int -> int -> int -> unit
  = "glstub_glVertexAttrib2s" "glstub_glVertexAttrib2s"
external glVertexAttrib2sARB : int -> int -> int -> unit
  = "glstub_glVertexAttrib2sARB" "glstub_glVertexAttrib2sARB"
external glVertexAttrib2sNV : int -> int -> int -> unit
  = "glstub_glVertexAttrib2sNV" "glstub_glVertexAttrib2sNV"
val glVertexAttrib2sv : int -> int array -> unit
val glVertexAttrib2svARB : int -> int array -> unit
val glVertexAttrib2svNV : int -> int array -> unit
external glVertexAttrib3d : int -> float -> float -> float -> unit
  = "glstub_glVertexAttrib3d" "glstub_glVertexAttrib3d"
external glVertexAttrib3dARB : int -> float -> float -> float -> unit
  = "glstub_glVertexAttrib3dARB" "glstub_glVertexAttrib3dARB"
external glVertexAttrib3dNV : int -> float -> float -> float -> unit
  = "glstub_glVertexAttrib3dNV" "glstub_glVertexAttrib3dNV"
external glVertexAttrib3dv : int -> float array -> unit
  = "glstub_glVertexAttrib3dv" "glstub_glVertexAttrib3dv"
external glVertexAttrib3dvARB : int -> float array -> unit
  = "glstub_glVertexAttrib3dvARB" "glstub_glVertexAttrib3dvARB"
external glVertexAttrib3dvNV : int -> float array -> unit
  = "glstub_glVertexAttrib3dvNV" "glstub_glVertexAttrib3dvNV"
external glVertexAttrib3f : int -> float -> float -> float -> unit
  = "glstub_glVertexAttrib3f" "glstub_glVertexAttrib3f"
external glVertexAttrib3fARB : int -> float -> float -> float -> unit
  = "glstub_glVertexAttrib3fARB" "glstub_glVertexAttrib3fARB"
external glVertexAttrib3fNV : int -> float -> float -> float -> unit
  = "glstub_glVertexAttrib3fNV" "glstub_glVertexAttrib3fNV"
val glVertexAttrib3fv : int -> float array -> unit
val glVertexAttrib3fvARB : int -> float array -> unit
val glVertexAttrib3fvNV : int -> float array -> unit
external glVertexAttrib3hNV : int -> int -> int -> int -> unit
  = "glstub_glVertexAttrib3hNV" "glstub_glVertexAttrib3hNV"
val glVertexAttrib3hvNV : int -> int array -> unit
external glVertexAttrib3s : int -> int -> int -> int -> unit
  = "glstub_glVertexAttrib3s" "glstub_glVertexAttrib3s"
external glVertexAttrib3sARB : int -> int -> int -> int -> unit
  = "glstub_glVertexAttrib3sARB" "glstub_glVertexAttrib3sARB"
external glVertexAttrib3sNV : int -> int -> int -> int -> unit
  = "glstub_glVertexAttrib3sNV" "glstub_glVertexAttrib3sNV"
val glVertexAttrib3sv : int -> int array -> unit
val glVertexAttrib3svARB : int -> int array -> unit
val glVertexAttrib3svNV : int -> int array -> unit
val glVertexAttrib4Nbv : int -> int array -> unit
val glVertexAttrib4NbvARB : int -> int array -> unit
val glVertexAttrib4Niv : int -> int array -> unit
val glVertexAttrib4NivARB : int -> int array -> unit
val glVertexAttrib4Nsv : int -> int array -> unit
val glVertexAttrib4NsvARB : int -> int array -> unit
external glVertexAttrib4Nub : int -> int -> int -> int -> int -> unit
  = "glstub_glVertexAttrib4Nub" "glstub_glVertexAttrib4Nub"
external glVertexAttrib4NubARB : int -> int -> int -> int -> int -> unit
  = "glstub_glVertexAttrib4NubARB" "glstub_glVertexAttrib4NubARB"
val glVertexAttrib4Nubv : int -> int array -> unit
val glVertexAttrib4NubvARB : int -> int array -> unit
val glVertexAttrib4Nuiv : int -> int array -> unit
val glVertexAttrib4NuivARB : int -> int array -> unit
val glVertexAttrib4Nusv : int -> int array -> unit
val glVertexAttrib4NusvARB : int -> int array -> unit
val glVertexAttrib4bv : int -> int array -> unit
val glVertexAttrib4bvARB : int -> int array -> unit
external glVertexAttrib4d : int -> float -> float -> float -> float -> unit
  = "glstub_glVertexAttrib4d" "glstub_glVertexAttrib4d"
external glVertexAttrib4dARB :
  int -> float -> float -> float -> float -> unit
  = "glstub_glVertexAttrib4dARB" "glstub_glVertexAttrib4dARB"
external glVertexAttrib4dNV : int -> float -> float -> float -> float -> unit
  = "glstub_glVertexAttrib4dNV" "glstub_glVertexAttrib4dNV"
external glVertexAttrib4dv : int -> float array -> unit
  = "glstub_glVertexAttrib4dv" "glstub_glVertexAttrib4dv"
external glVertexAttrib4dvARB : int -> float array -> unit
  = "glstub_glVertexAttrib4dvARB" "glstub_glVertexAttrib4dvARB"
external glVertexAttrib4dvNV : int -> float array -> unit
  = "glstub_glVertexAttrib4dvNV" "glstub_glVertexAttrib4dvNV"
external glVertexAttrib4f : int -> float -> float -> float -> float -> unit
  = "glstub_glVertexAttrib4f" "glstub_glVertexAttrib4f"
external glVertexAttrib4fARB :
  int -> float -> float -> float -> float -> unit
  = "glstub_glVertexAttrib4fARB" "glstub_glVertexAttrib4fARB"
external glVertexAttrib4fNV : int -> float -> float -> float -> float -> unit
  = "glstub_glVertexAttrib4fNV" "glstub_glVertexAttrib4fNV"
val glVertexAttrib4fv : int -> float array -> unit
val glVertexAttrib4fvARB : int -> float array -> unit
val glVertexAttrib4fvNV : int -> float array -> unit
external glVertexAttrib4hNV : int -> int -> int -> int -> int -> unit
  = "glstub_glVertexAttrib4hNV" "glstub_glVertexAttrib4hNV"
val glVertexAttrib4hvNV : int -> int array -> unit
val glVertexAttrib4iv : int -> int array -> unit
val glVertexAttrib4ivARB : int -> int array -> unit
external glVertexAttrib4s : int -> int -> int -> int -> int -> unit
  = "glstub_glVertexAttrib4s" "glstub_glVertexAttrib4s"
external glVertexAttrib4sARB : int -> int -> int -> int -> int -> unit
  = "glstub_glVertexAttrib4sARB" "glstub_glVertexAttrib4sARB"
external glVertexAttrib4sNV : int -> int -> int -> int -> int -> unit
  = "glstub_glVertexAttrib4sNV" "glstub_glVertexAttrib4sNV"
val glVertexAttrib4sv : int -> int array -> unit
val glVertexAttrib4svARB : int -> int array -> unit
val glVertexAttrib4svNV : int -> int array -> unit
external glVertexAttrib4ubNV : int -> int -> int -> int -> int -> unit
  = "glstub_glVertexAttrib4ubNV" "glstub_glVertexAttrib4ubNV"
val glVertexAttrib4ubv : int -> int array -> unit
val glVertexAttrib4ubvARB : int -> int array -> unit
val glVertexAttrib4ubvNV : int -> int array -> unit
val glVertexAttrib4uiv : int -> int array -> unit
val glVertexAttrib4uivARB : int -> int array -> unit
val glVertexAttrib4usv : int -> int array -> unit
val glVertexAttrib4usvARB : int -> int array -> unit
external glVertexAttribArrayObjectATI :
  int -> int -> int -> bool -> int -> int -> int -> unit
  = "glstub_glVertexAttribArrayObjectATI_byte"
  "glstub_glVertexAttribArrayObjectATI"
external glVertexAttribI1iEXT : int -> int -> unit
  = "glstub_glVertexAttribI1iEXT" "glstub_glVertexAttribI1iEXT"
val glVertexAttribI1ivEXT : int -> int array -> unit
external glVertexAttribI1uiEXT : int -> int -> unit
  = "glstub_glVertexAttribI1uiEXT" "glstub_glVertexAttribI1uiEXT"
val glVertexAttribI1uivEXT : int -> int array -> unit
external glVertexAttribI2iEXT : int -> int -> int -> unit
  = "glstub_glVertexAttribI2iEXT" "glstub_glVertexAttribI2iEXT"
val glVertexAttribI2ivEXT : int -> int array -> unit
external glVertexAttribI2uiEXT : int -> int -> int -> unit
  = "glstub_glVertexAttribI2uiEXT" "glstub_glVertexAttribI2uiEXT"
val glVertexAttribI2uivEXT : int -> int array -> unit
external glVertexAttribI3iEXT : int -> int -> int -> int -> unit
  = "glstub_glVertexAttribI3iEXT" "glstub_glVertexAttribI3iEXT"
val glVertexAttribI3ivEXT : int -> int array -> unit
external glVertexAttribI3uiEXT : int -> int -> int -> int -> unit
  = "glstub_glVertexAttribI3uiEXT" "glstub_glVertexAttribI3uiEXT"
val glVertexAttribI3uivEXT : int -> int array -> unit
val glVertexAttribI4bvEXT : int -> int array -> unit
external glVertexAttribI4iEXT : int -> int -> int -> int -> int -> unit
  = "glstub_glVertexAttribI4iEXT" "glstub_glVertexAttribI4iEXT"
val glVertexAttribI4ivEXT : int -> int array -> unit
val glVertexAttribI4svEXT : int -> int array -> unit
val glVertexAttribI4ubvEXT : int -> int array -> unit
external glVertexAttribI4uiEXT : int -> int -> int -> int -> int -> unit
  = "glstub_glVertexAttribI4uiEXT" "glstub_glVertexAttribI4uiEXT"
val glVertexAttribI4uivEXT : int -> int array -> unit
val glVertexAttribI4usvEXT : int -> int array -> unit
external glVertexAttribIPointerEXT : int -> int -> int -> int -> 'a -> unit
  = "glstub_glVertexAttribIPointerEXT" "glstub_glVertexAttribIPointerEXT"
external glVertexAttribPointer :
  int -> int -> int -> bool -> int -> 'a -> unit
  = "glstub_glVertexAttribPointer_byte" "glstub_glVertexAttribPointer"
external glVertexAttribPointerARB :
  int -> int -> int -> bool -> int -> 'a -> unit
  = "glstub_glVertexAttribPointerARB_byte" "glstub_glVertexAttribPointerARB"
external glVertexAttribPointerNV : int -> int -> int -> int -> 'a -> unit
  = "glstub_glVertexAttribPointerNV" "glstub_glVertexAttribPointerNV"
external glVertexAttribs1dvNV : int -> int -> float array -> unit
  = "glstub_glVertexAttribs1dvNV" "glstub_glVertexAttribs1dvNV"
val glVertexAttribs1fvNV : int -> int -> float array -> unit
val glVertexAttribs1hvNV : int -> int -> int array -> unit
val glVertexAttribs1svNV : int -> int -> int array -> unit
external glVertexAttribs2dvNV : int -> int -> float array -> unit
  = "glstub_glVertexAttribs2dvNV" "glstub_glVertexAttribs2dvNV"
val glVertexAttribs2fvNV : int -> int -> float array -> unit
val glVertexAttribs2hvNV : int -> int -> int array -> unit
val glVertexAttribs2svNV : int -> int -> int array -> unit
external glVertexAttribs3dvNV : int -> int -> float array -> unit
  = "glstub_glVertexAttribs3dvNV" "glstub_glVertexAttribs3dvNV"
val glVertexAttribs3fvNV : int -> int -> float array -> unit
val glVertexAttribs3hvNV : int -> int -> int array -> unit
val glVertexAttribs3svNV : int -> int -> int array -> unit
external glVertexAttribs4dvNV : int -> int -> float array -> unit
  = "glstub_glVertexAttribs4dvNV" "glstub_glVertexAttribs4dvNV"
val glVertexAttribs4fvNV : int -> int -> float array -> unit
val glVertexAttribs4hvNV : int -> int -> int array -> unit
val glVertexAttribs4svNV : int -> int -> int array -> unit
val glVertexAttribs4ubvNV : int -> int -> int array -> unit
external glVertexBlendARB : int -> unit = "glstub_glVertexBlendARB"
  "glstub_glVertexBlendARB"
external glVertexBlendEnvfATI : int -> float -> unit
  = "glstub_glVertexBlendEnvfATI" "glstub_glVertexBlendEnvfATI"
external glVertexBlendEnviATI : int -> int -> unit
  = "glstub_glVertexBlendEnviATI" "glstub_glVertexBlendEnviATI"
external glVertexPointer : int -> int -> int -> 'a -> unit
  = "glstub_glVertexPointer" "glstub_glVertexPointer"
external glVertexPointerEXT : int -> int -> int -> int -> 'a -> unit
  = "glstub_glVertexPointerEXT" "glstub_glVertexPointerEXT"
external glVertexPointerListIBM : int -> int -> int -> 'a -> int -> unit
  = "glstub_glVertexPointerListIBM" "glstub_glVertexPointerListIBM"
external glVertexPointervINTEL : int -> int -> 'a -> unit
  = "glstub_glVertexPointervINTEL" "glstub_glVertexPointervINTEL"
external glVertexStream2dATI : int -> float -> float -> unit
  = "glstub_glVertexStream2dATI" "glstub_glVertexStream2dATI"
external glVertexStream2dvATI : int -> float array -> unit
  = "glstub_glVertexStream2dvATI" "glstub_glVertexStream2dvATI"
external glVertexStream2fATI : int -> float -> float -> unit
  = "glstub_glVertexStream2fATI" "glstub_glVertexStream2fATI"
val glVertexStream2fvATI : int -> float array -> unit
external glVertexStream2iATI : int -> int -> int -> unit
  = "glstub_glVertexStream2iATI" "glstub_glVertexStream2iATI"
val glVertexStream2ivATI : int -> int array -> unit
external glVertexStream2sATI : int -> int -> int -> unit
  = "glstub_glVertexStream2sATI" "glstub_glVertexStream2sATI"
val glVertexStream2svATI : int -> int array -> unit
external glVertexStream3dATI : int -> float -> float -> float -> unit
  = "glstub_glVertexStream3dATI" "glstub_glVertexStream3dATI"
external glVertexStream3dvATI : int -> float array -> unit
  = "glstub_glVertexStream3dvATI" "glstub_glVertexStream3dvATI"
external glVertexStream3fATI : int -> float -> float -> float -> unit
  = "glstub_glVertexStream3fATI" "glstub_glVertexStream3fATI"
val glVertexStream3fvATI : int -> float array -> unit
external glVertexStream3iATI : int -> int -> int -> int -> unit
  = "glstub_glVertexStream3iATI" "glstub_glVertexStream3iATI"
val glVertexStream3ivATI : int -> int array -> unit
external glVertexStream3sATI : int -> int -> int -> int -> unit
  = "glstub_glVertexStream3sATI" "glstub_glVertexStream3sATI"
val glVertexStream3svATI : int -> int array -> unit
external glVertexStream4dATI :
  int -> float -> float -> float -> float -> unit
  = "glstub_glVertexStream4dATI" "glstub_glVertexStream4dATI"
external glVertexStream4dvATI : int -> float array -> unit
  = "glstub_glVertexStream4dvATI" "glstub_glVertexStream4dvATI"
external glVertexStream4fATI :
  int -> float -> float -> float -> float -> unit
  = "glstub_glVertexStream4fATI" "glstub_glVertexStream4fATI"
val glVertexStream4fvATI : int -> float array -> unit
external glVertexStream4iATI : int -> int -> int -> int -> int -> unit
  = "glstub_glVertexStream4iATI" "glstub_glVertexStream4iATI"
val glVertexStream4ivATI : int -> int array -> unit
external glVertexStream4sATI : int -> int -> int -> int -> int -> unit
  = "glstub_glVertexStream4sATI" "glstub_glVertexStream4sATI"
val glVertexStream4svATI : int -> int array -> unit
external glVertexWeightPointerEXT : int -> int -> int -> 'a -> unit
  = "glstub_glVertexWeightPointerEXT" "glstub_glVertexWeightPointerEXT"
external glVertexWeightfEXT : float -> unit = "glstub_glVertexWeightfEXT"
  "glstub_glVertexWeightfEXT"
val glVertexWeightfvEXT : float array -> unit
external glVertexWeighthNV : int -> unit = "glstub_glVertexWeighthNV"
  "glstub_glVertexWeighthNV"
val glVertexWeighthvNV : int array -> unit
external glViewport : int -> int -> int -> int -> unit = "glstub_glViewport"
  "glstub_glViewport"
external glWeightPointerARB : int -> int -> int -> 'a -> unit
  = "glstub_glWeightPointerARB" "glstub_glWeightPointerARB"
val glWeightbvARB : int -> int array -> unit
external glWeightdvARB : int -> float array -> unit = "glstub_glWeightdvARB"
  "glstub_glWeightdvARB"
val glWeightfvARB : int -> float array -> unit
val glWeightivARB : int -> int array -> unit
val glWeightsvARB : int -> int array -> unit
val glWeightubvARB : int -> int array -> unit
val glWeightuivARB : int -> int array -> unit
val glWeightusvARB : int -> int array -> unit
external glWindowPos2d : float -> float -> unit = "glstub_glWindowPos2d"
  "glstub_glWindowPos2d"
external glWindowPos2dARB : float -> float -> unit
  = "glstub_glWindowPos2dARB" "glstub_glWindowPos2dARB"
external glWindowPos2dMESA : float -> float -> unit
  = "glstub_glWindowPos2dMESA" "glstub_glWindowPos2dMESA"
external glWindowPos2dv : float array -> unit = "glstub_glWindowPos2dv"
  "glstub_glWindowPos2dv"
external glWindowPos2dvARB : float array -> unit = "glstub_glWindowPos2dvARB"
  "glstub_glWindowPos2dvARB"
external glWindowPos2dvMESA : float array -> unit
  = "glstub_glWindowPos2dvMESA" "glstub_glWindowPos2dvMESA"
external glWindowPos2f : float -> float -> unit = "glstub_glWindowPos2f"
  "glstub_glWindowPos2f"
external glWindowPos2fARB : float -> float -> unit
  = "glstub_glWindowPos2fARB" "glstub_glWindowPos2fARB"
external glWindowPos2fMESA : float -> float -> unit
  = "glstub_glWindowPos2fMESA" "glstub_glWindowPos2fMESA"
val glWindowPos2fv : float array -> unit
val glWindowPos2fvARB : float array -> unit
val glWindowPos2fvMESA : float array -> unit
external glWindowPos2i : int -> int -> unit = "glstub_glWindowPos2i"
  "glstub_glWindowPos2i"
external glWindowPos2iARB : int -> int -> unit = "glstub_glWindowPos2iARB"
  "glstub_glWindowPos2iARB"
external glWindowPos2iMESA : int -> int -> unit = "glstub_glWindowPos2iMESA"
  "glstub_glWindowPos2iMESA"
val glWindowPos2iv : int array -> unit
val glWindowPos2ivARB : int array -> unit
val glWindowPos2ivMESA : int array -> unit
external glWindowPos2s : int -> int -> unit = "glstub_glWindowPos2s"
  "glstub_glWindowPos2s"
external glWindowPos2sARB : int -> int -> unit = "glstub_glWindowPos2sARB"
  "glstub_glWindowPos2sARB"
external glWindowPos2sMESA : int -> int -> unit = "glstub_glWindowPos2sMESA"
  "glstub_glWindowPos2sMESA"
val glWindowPos2sv : int array -> unit
val glWindowPos2svARB : int array -> unit
val glWindowPos2svMESA : int array -> unit
external glWindowPos3d : float -> float -> float -> unit
  = "glstub_glWindowPos3d" "glstub_glWindowPos3d"
external glWindowPos3dARB : float -> float -> float -> unit
  = "glstub_glWindowPos3dARB" "glstub_glWindowPos3dARB"
external glWindowPos3dMESA : float -> float -> float -> unit
  = "glstub_glWindowPos3dMESA" "glstub_glWindowPos3dMESA"
external glWindowPos3dv : float array -> unit = "glstub_glWindowPos3dv"
  "glstub_glWindowPos3dv"
external glWindowPos3dvARB : float array -> unit = "glstub_glWindowPos3dvARB"
  "glstub_glWindowPos3dvARB"
external glWindowPos3dvMESA : float array -> unit
  = "glstub_glWindowPos3dvMESA" "glstub_glWindowPos3dvMESA"
external glWindowPos3f : float -> float -> float -> unit
  = "glstub_glWindowPos3f" "glstub_glWindowPos3f"
external glWindowPos3fARB : float -> float -> float -> unit
  = "glstub_glWindowPos3fARB" "glstub_glWindowPos3fARB"
external glWindowPos3fMESA : float -> float -> float -> unit
  = "glstub_glWindowPos3fMESA" "glstub_glWindowPos3fMESA"
val glWindowPos3fv : float array -> unit
val glWindowPos3fvARB : float array -> unit
val glWindowPos3fvMESA : float array -> unit
external glWindowPos3i : int -> int -> int -> unit = "glstub_glWindowPos3i"
  "glstub_glWindowPos3i"
external glWindowPos3iARB : int -> int -> int -> unit
  = "glstub_glWindowPos3iARB" "glstub_glWindowPos3iARB"
external glWindowPos3iMESA : int -> int -> int -> unit
  = "glstub_glWindowPos3iMESA" "glstub_glWindowPos3iMESA"
val glWindowPos3iv : int array -> unit
val glWindowPos3ivARB : int array -> unit
val glWindowPos3ivMESA : int array -> unit
external glWindowPos3s : int -> int -> int -> unit = "glstub_glWindowPos3s"
  "glstub_glWindowPos3s"
external glWindowPos3sARB : int -> int -> int -> unit
  = "glstub_glWindowPos3sARB" "glstub_glWindowPos3sARB"
external glWindowPos3sMESA : int -> int -> int -> unit
  = "glstub_glWindowPos3sMESA" "glstub_glWindowPos3sMESA"
val glWindowPos3sv : int array -> unit
val glWindowPos3svARB : int array -> unit
val glWindowPos3svMESA : int array -> unit
external glWindowPos4dMESA : float -> float -> float -> float -> unit
  = "glstub_glWindowPos4dMESA" "glstub_glWindowPos4dMESA"
external glWindowPos4dvMESA : float array -> unit
  = "glstub_glWindowPos4dvMESA" "glstub_glWindowPos4dvMESA"
external glWindowPos4fMESA : float -> float -> float -> float -> unit
  = "glstub_glWindowPos4fMESA" "glstub_glWindowPos4fMESA"
val glWindowPos4fvMESA : float array -> unit
external glWindowPos4iMESA : int -> int -> int -> int -> unit
  = "glstub_glWindowPos4iMESA" "glstub_glWindowPos4iMESA"
val glWindowPos4ivMESA : int array -> unit
external glWindowPos4sMESA : int -> int -> int -> int -> unit
  = "glstub_glWindowPos4sMESA" "glstub_glWindowPos4sMESA"
val glWindowPos4svMESA : int array -> unit
external glWriteMaskEXT : int -> int -> int -> int -> int -> int -> unit
  = "glstub_glWriteMaskEXT_byte" "glstub_glWriteMaskEXT"
