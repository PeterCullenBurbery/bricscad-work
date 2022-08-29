;This is an example script provided with the installation of BricsCAD V22.
;
;This script is provided AS IS without warranty of any kind. Author(s) disclaim all
;implied warranties including, without limitation, any implied warranties of
;merchantability or of fitness for a particular purpose. The entire risk arising out of
;the use or performance of the sample script and documentation remains with you. In no
;event shall author(s) be held liable for any damages whatsoever (including, without
;limitation, damages for loss of business profits, business interruption, loss of business
;information, or other pecuniary loss) arising out of the use of or inability to use the
;script or documentation. The script is not guaranteed to work with future or previous
;versions of BricsCAD except the one it is installed with. The presensce of the script in
;future versions is not guaranteed and is a subject to change within any future update to
;BricsCAD.


;This script runs trough the list of named views, activate each view and uses the PNGOUT command to generate a rasterimage in the project subfolder /Images
(vl-load-com)

(defun c:View2Png ( / myView pngfile )
  (setvar "cmdecho" 0)  ;echo off
  (vlax-for myView (vla-get-Views (vla-get-ActiveDocument (vlax-get-Acad-Object)))
    (progn
;      (alert (strcat "View: " (vla-get-Name myView)))
      (print (strcat "View: " (vla-get-Name myView)))
      (command "_-view" "_Restore" (vla-get-Name myView))
      (vl-mkdir (strcat (getvar "DWGPREFIX") "Images"))  ;check if dir exists and create

      (setq pngfile (strcat (getvar "DWGPREFIX") "Images/" (vla-get-Name myView) ".png"))
      (vl-file-delete pngfile)
      (command "_pngout" pngfile)
    )
  )
  (setvar "cmdecho" 1)  ;echo on
  (princ)
)

(c:View2Png)
(princ)
