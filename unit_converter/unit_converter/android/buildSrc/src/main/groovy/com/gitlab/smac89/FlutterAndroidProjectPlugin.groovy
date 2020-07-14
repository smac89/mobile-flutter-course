package com.gitlab.smac89

import groovy.transform.CompileStatic
import org.gradle.api.Plugin
import org.gradle.api.Project

@CompileStatic
class FlutterAndroidProjectPlugin implements Plugin<Project> {
    private File localPropsFile
    @Lazy private FlutterLocalProps localProps = 
            FlutterLocalProps.from localPropsFile

    @Override
    void apply(Project project) {
        localPropsFile = new File(project.rootProject.projectDir, "local.properties")
        project.rootProject.subprojects { Project sub ->
            sub.beforeEvaluate {
                localProps.applyToExtension sub.extensions
            }
        }
    }
}
