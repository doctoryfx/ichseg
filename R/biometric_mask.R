#' @title Estimate Biometric Masks
#' @description Estimates biometric masks for anonymization, such as the face and
#' ears.
#'
#' @param file Filename (or nifti) of image
#' @param type character of \code{ct} for CT images or \code{mri} for magnetic
#' resonance images
#' @param ... arguments to pass to \code{ct/mri_ear_mask} and
#' \code{ct/mri_face_mask}
#'
#' @return Object of class nifti
#' @export
#' @examples \dontrun{
#' file = "~/Desktop/Desktop/scratch/100-318_20070723_0957_CT_3_CT_Head-.nii.gz"
#' mask = NULL
#' robust = FALSE
#' mask = ct_biometric_mask(
#'    file = file,
#'    robust = FALSE
#'    )
#'  img = readnii(file)
#'  rimg = randomize_mask(img, mask = face)
#' }
#'
biometric_mask = function(
  file,
  type = c("ct", "mri"),
  ...) {
  type = match.arg(type)

  args = list(...)
  args$file = file

  func = paste0(type, "_ear_mask")
  ears = do.call(what = func, args = args)

  func = paste0(type, "_face_mask")
  face = do.call(what = func, args = args)
  mask = ears | face
  return(mask)
}

#' @export
#' @rdname biometric_mask
ct_biometric_mask = function(
  file,
  ...) {

  args = list(...)
  args$type = "ct"
  args$file = file

  mask = do.call("biometric_mask", args = args)
  return(mask)
}

#' @export
#' @rdname biometric_mask
mri_biometric_mask = function(
  file,
  ...) {

  args = list(...)
  args$type = "mri"
  args$file = file

  mask = do.call("biometric_mask", args = args)
  return(mask)
}
