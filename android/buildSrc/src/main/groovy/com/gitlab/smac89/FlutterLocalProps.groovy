package com.gitlab.smac89

import groovy.transform.PackageScope
import org.gradle.api.plugins.ExtensionContainer

class FlutterLocalProps extends Expando {
    private boolean addedToContainer = false

    @PackageScope
    void applyToExtension(ExtensionContainer container) {
        if (!addedToContainer) {
            container.add("localProps", this)
        }
    }

    static FlutterLocalProps from(File localPropsFile) {
        def localProps = new Properties().tap { p  ->
            if (localPropsFile.exists()) {
                localPropsFile.withReader("utf-8") {
                    p.load(it)
                }
            }
        }

        new FlutterLocalProps().tap {
            localProps.stringPropertyNames().each { key ->
                it[key] = localProps.getProperty(key)
            }
        }
    }
}
