!!$ 
!!$              Parallel Sparse BLAS  version 3.0
!!$    (C) Copyright 2006, 2007, 2008, 2009, 2010
!!$                       Salvatore Filippone    University of Rome Tor Vergata
!!$                       Alfredo Buttari        CNRS-IRIT, Toulouse
!!$ 
!!$  Redistribution and use in source and binary forms, with or without
!!$  modification, are permitted provided that the following conditions
!!$  are met:
!!$    1. Redistributions of source code must retain the above copyright
!!$       notice, this list of conditions and the following disclaimer.
!!$    2. Redistributions in binary form must reproduce the above copyright
!!$       notice, this list of conditions, and the following disclaimer in the
!!$       documentation and/or other materials provided with the distribution.
!!$    3. The name of the PSBLAS group or the names of its contributors may
!!$       not be used to endorse or promote products derived from this
!!$       software without specific written permission.
!!$ 
!!$  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
!!$  ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
!!$  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
!!$  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE PSBLAS GROUP OR ITS CONTRIBUTORS
!!$  BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
!!$  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
!!$  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
!!$  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
!!$  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
!!$  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
!!$  POSSIBILITY OF SUCH DAMAGE.
!!$ 
!!$  
!
!
! package: psb_linmap_type_mod
!    Defines data types for mapping between vectors belonging
!    to different spaces.
!
module psb_base_linmap_mod
  use psb_const_mod
  use psb_descriptor_type, only: psb_desc_type
  

  type psb_base_linmap_type
    integer :: kind
    integer, allocatable  :: iaggr(:), naggr(:)
    type(psb_desc_type), pointer :: p_desc_X=>null(), p_desc_Y=>null()
    type(psb_desc_type)   :: desc_X, desc_Y
  contains
    procedure, pass(map)  :: sizeof   => base_map_sizeof
    procedure, pass(map)  :: is_ok    => base_is_ok
    procedure, pass(map)  :: is_asb   => base_is_asb
    procedure, pass(map)  :: get_kind => base_get_kind
    procedure, pass(map)  :: set_kind => base_set_kind
  end type psb_base_linmap_type


  interface psb_move_alloc
    module procedure  psb_base_linmap_transfer
  end interface

  private :: base_map_sizeof, base_is_ok, base_is_asb,&
       & base_get_kind, base_set_kind

contains

  function base_get_kind(map) result(val)
    implicit none
    class(psb_base_linmap_type), intent(in) :: map
    Integer                      :: val
  
    val = map%kind
  end function base_get_kind


  subroutine base_set_kind(map_kind,map)    
    implicit none
    integer, intent(in)          :: map_kind
    class(psb_base_linmap_type), intent(inout) :: map

    map%kind = map_kind

  end subroutine base_set_kind


  function base_is_ok(map) result(this)
    use psb_descriptor_type
    implicit none 
    class(psb_base_linmap_type), intent(in) :: map
    logical  :: this
    this = .false.

    select case(map%get_kind())
    case (psb_map_aggr_)
      if (.not.associated(map%p_desc_X)) return
      if (.not.associated(map%p_desc_Y)) return
      this = map%p_desc_X%is_ok().and.map%p_desc_Y%is_ok()    
    case(psb_map_gen_linear_)    
      this = map%desc_X%is_ok().and.map%desc_Y%is_ok()    
    end select

  end function base_is_ok

  function base_is_asb(map) result(this)
    use psb_descriptor_type
    implicit none 
    class(psb_base_linmap_type), intent(in) :: map
    logical  :: this
    this = .false.

    select case(map%get_kind())
    case (psb_map_aggr_)
      if (.not.associated(map%p_desc_X)) return
      if (.not.associated(map%p_desc_Y)) return
      this = map%p_desc_X%is_asb().and.map%p_desc_Y%is_asb()    
    case(psb_map_gen_linear_)    
      this = map%desc_X%is_asb().and.map%desc_Y%is_asb()    
    end select

  end function base_is_asb

  function base_map_sizeof(map) result(val)
    use psb_descriptor_type
    implicit none 
    class(psb_base_linmap_type), intent(in) :: map
    integer(psb_long_int_k_) :: val

    val = psb_sizeof_int
    if (allocated(map%iaggr))   &
         & val = val + psb_sizeof_int*size(map%iaggr)
    if (allocated(map%naggr))   &
         & val = val + psb_sizeof_int*size(map%naggr)
    val = val + map%desc_X%sizeof()
    val = val + map%desc_Y%sizeof()

  end function base_map_sizeof
  
  subroutine  psb_base_linmap_transfer(mapin,mapout,info)
    use psb_realloc_mod
    use psb_descriptor_type
    use psb_mat_mod, only : psb_move_alloc
    implicit none 
    type(psb_base_linmap_type) :: mapin,mapout
    integer, intent(out)       :: info 
    
    mapout%kind = mapin%kind
    call psb_move_alloc(mapin%iaggr,mapout%iaggr,info)
    call psb_move_alloc(mapin%naggr,mapout%naggr,info)
    mapout%p_desc_X => mapin%p_desc_X 
    mapin%p_desc_X  => null()
    mapout%p_desc_Y => mapin%p_desc_Y
    mapin%p_desc_Y  => null()
    call psb_move_alloc(mapin%desc_X,mapout%desc_X,info)
    call psb_move_alloc(mapin%desc_Y,mapout%desc_Y,info)

  end subroutine psb_base_linmap_transfer
  


end module psb_base_linmap_mod

