# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Gramps < Formula
  desc "not to be used yet - yg"
  homepage ""

  head "https://github.com/gramps-project/gramps", :shallow => true

  stable do
    url "https://github.com/gramps-project/gramps"
    version "5.1.3"
    sha256 ""
  end

  # depends_on "cmake" => :build

  def install
    system "python", "setup.py" "build"
    # system "python", "setup.py" "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test gramps`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

__END__

github.setup            gramps-project gramps 4.2.5 v
revision                1

PortGroup               python 1.0

conflicts               gramps3
license                 GPL-2
categories              genealogy python
platforms               darwin
supported_archs         noarch
maintainers             {devans @dbevans} openmaintainer
           
description             GRAMPS is a genealogy program

long_description        GRAMPS is a genealogy program to store, edit, \
                        and research genealogical data.  It provides \
                        advanced capabilities for research, analysis, and \
                        correlation to potentially fill relationship gaps. This \
                        version is based on gtk3 and supports both python 2 and 3. \
                        To use the legacy gtk2 version, install port gramps3.

homepage                http://www.gramps-project.org/

checksums               rmd160  08c88b4e7b21d3c7f485424b7f59f35574899fa0 \
                        sha256  8e450b54f81049555c270bbce453f873b8e251f71979f529cd68b044c2238bb7

depends_build-append    port:intltool

depends_lib-append      port:desktop-file-utils \
                        port:shared-mime-info \
                        port:xdg-utils \
                        port:gtk3 \
                        port:gtkspell3 \
                        port:osm-gps-map \
                        port:gexiv2 \
                        path:bin/dot:graphviz \
                        port:ghostscript \
                        port:goocanvas2

depends_run             port:gnome-themes-standard

patchfiles              patch-gramps-gen-utils-resourcepath.py.diff

# versions 4.2.0+ only support python 3

variant python34 conflicts python35 python36 description {Use Python 3.4} {
    python.default_version  34
    depends_lib-append  port:py34-gobject3 \
                        port:py34-pyicu \
                        port:py34-Pillow \
                        port:py34-bsddb3
}

variant python35 conflicts python34 python36 description {Use Python 3.5} {
    python.default_version  35
    depends_lib-append  port:py35-gobject3 \
                        port:py35-pyicu \
                        port:py35-Pillow \
                        port:py35-bsddb3
}

variant python36 conflicts python34 python35 description {Use Python 3.6} {
    python.default_version  36
    depends_lib-append  port:py36-gobject3 \
                        port:py36-pyicu \
                        port:py36-Pillow \
                        port:py36-bsddb3
}

if {![variant_isset python35] && ![variant_isset python36]} {
    default_variants    +python34
}

post-destroot {
    reinplace "s|${destroot}${python.prefix}|${prefix}|" ${destroot}${python.pkgd}/gramps/gen/utils/resource-path
    delete ${destroot}${prefix}/share
    move ${destroot}${python.prefix}/share ${destroot}${prefix}
}

post-activate {
    system "${prefix}/bin/update-desktop-database ${prefix}/share/applications"
    system "${prefix}/bin/update-mime-database ${prefix}/share/mime"
}

notes {

When using GRAMPS, be sure to backup your data regularly! GRAMPS backups are in XML format.
XML is machine- and human-readable. It is completely self-sufficient. It is also small.

The following are good backup practices:

    Backup to XML from time to time, especially after large edits.
    Backup to XML before making big changes, such as importing new data into an existing database from e.g. GEDCOM,
        merging records, running tools that may heavily modify the data, etc.
    Backup to XML before upgrading GRAMPS to a newer version. Backup to XML with the old version before you install
        the new one!
    Backup to XML before upgrading your OS.

Also, use XML format for any data migration. Moving to another machine, sending data to a family member,
copying to another user on the same machine -- all of these cases should use XML.

***** IMPORTANT *****

Beginning with GRAMPS 4.2, GRAMPS only supports python3.  Please MAKE A BACKUP of your data using your old python2 version
before attempting to load your family tree in GRAMPS 4.2 with python3.  The python3 versions use a different database
interface with a new database format that is not compatible with the python2 versions. On startup, GRAMPS 4.2 will ask you
if you want to reformat your database.  Once this has been done, your database will no longer be usable with python2 versions of GRAMPS.

***** MAKE A BACKUP! *****

For detailed backup instructions, see the online GRAMPS documentation at http://www.gramps-project.org/wiki/index.php?title=How_to_make_a_backup

}

livecheck.regex         "archive/v(4\[^\"\]+).tar.gz"
