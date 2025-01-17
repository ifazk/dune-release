open Alcotest

let path = testable Fpath.pp Fpath.equal

let error_msg =
  testable Bos_setup.R.pp_msg (fun (`Msg e1) (`Msg e2) -> String.equal e1 e2)

let result_msg testable = result testable error_msg

module Tag = Dune_release.Vcs.Tag

let tag = Alcotest.testable Tag.pp Tag.equal

module Version = Dune_release.Version

let changelog_version =
  Alcotest.testable Version.Changelog.pp Version.Changelog.equal

let opam_version =
  testable Dune_release.Opam.Version.pp Dune_release.Opam.Version.equal

let curl =
  let pp fs Dune_release.Curl.{ url; meth; args } =
    let args = Dune_release.Curl_option.to_string_list args in
    Format.fprintf fs "url = %S;@ " url;
    Format.fprintf fs "meth = %a@ " Curly.Meth.pp meth;
    Format.fprintf fs "args = %a@\n" (Fmt.list ~sep:Fmt.sp Fmt.string) args
  in
  testable pp ( = )
