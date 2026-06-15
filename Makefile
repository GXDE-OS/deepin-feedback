PREFIX = /usr

ifndef USE_GCCGO
    GOBUILD = go build
else
   LDFLAGS = $(shell pkg-config --libs gio-2.0)
   GOBUILD = go build -compiler gccgo -gccgoflags "${LDFLAGS}"
endif

LANGUAGES = $(basename $(notdir $(wildcard misc/po/*.po)))

all: build

build/locale/%/LC_MESSAGES/gxde-feedback.mo:misc/po/%.po
	mkdir -p $(@D)
	msgfmt -o $@ $<

translate: $(addsuffix /LC_MESSAGES/gxde-feedback.mo, $(addprefix build/locale/, ${LANGUAGES}))

build: check translate
	mkdir -p build
	(cd cli; go build -o ../build/feedbackserver feedbackserver.go)
	deepin-policy-ts-convert ts2policy misc/com.deepin.gxde-feedback.policy.in misc/ts/com.deepin.gxde-feedback.policy build/com.deepin.gxde-feedback.policy
	deepin-desktop-ts-convert ts2desktop misc/gxde-feedback.desktop.in misc/ts/gxde-feedback.desktop build/gxde-feedback.desktop

ts:
	deepin-policy-ts-convert policy2ts misc/com.deepin.gxde-feedback.policy.in misc/ts/com.deepin.gxde-feedback.policy
	deepin-desktop-ts-convert desktop2ts misc/gxde-feedback.desktop.in misc/ts/gxde-feedback.desktop

pot:
	xgettext -LShell --from-code UTF-8 --keyword=gettext -o misc/po/gxde-feedback-cli.pot cli/gxde-feedback-cli.sh gxde-feedback

install:
	install -dm0755 ${DESTDIR}${PREFIX}/bin/
	mkdir -p ${DESTDIR}/var/lib/gxde-feedback/
	cp -rf feedback_logpath.json ${DESTDIR}/var/lib/gxde-feedback/feedback_logpath.json
	install -m0755 cli/gxde-feedback-cli.sh ${DESTDIR}${PREFIX}/bin/gxde-feedback-cli
	install -m0755 build/feedbackserver ${DESTDIR}${PREFIX}/bin/
	install -m0755 gxde-feedback ${DESTDIR}${PREFIX}/bin/
	install -dm0755 ${DESTDIR}${PREFIX}/share/applications
	install -m0755 build/gxde-feedback.desktop ${DESTDIR}${PREFIX}/share/applications/
	cp -rf misc/icons ${DESTDIR}${PREFIX}/share/
	install -dm0755 ${DESTDIR}${PREFIX}/share/polkit-1/actions/
	install -m0644 build/com.deepin.gxde-feedback.policy ${DESTDIR}${PREFIX}/share/polkit-1/actions/
	install -dm0755 ${DESTDIR}${PREFIX}/share/locale/
	cp -r build/locale/* ${DESTDIR}${PREFIX}/share/locale

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/gxde-feedback-cli
	rm -f /var/lib/gxde-feedback/feedback_logpath.json
	rm -f ${DESTDIR}${PREFIX}/share/applications/gxde-feedback.desktop
	rm -f ${DESTDIR}${PREFIX}/share/icons/hicolor/scalable/apps/gxde-feedback.svg

check:
	bash --norc -n -- cli/gxde-feedback-cli.sh

clean:
	$(RM) -r build
