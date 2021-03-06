package org.uqbar.project.wollok.ui

import java.net.URL
import org.eclipse.jface.resource.ImageDescriptor
import org.eclipse.jface.viewers.ILabelProvider
import org.eclipse.swt.widgets.Display
import org.eclipse.xtext.ui.editor.GlobalURIEditorOpener
import org.eclipse.xtext.ui.editor.IURIEditorOpener
import org.osgi.framework.BundleContext
import org.uqbar.project.wollok.ui.internal.WollokDslActivator

/**
 * Customized activator.
 * 
 * @author jfernandes
 */
class WollokActivator extends WollokDslActivator {
	//package name where the "messages.properties" is
	public static val BUNDLE_NAME = "org.uqbar.project.wollok.ui.messages" 

	def static WollokActivator getInstance() {
		return WollokDslActivator.getInstance as WollokActivator
	}
	
	override start(BundleContext context) throws Exception {
		super.start(context)
	}

	def static getStandardDisplay() {
		val display = Display.getCurrent
		if (display == null)
			return Display.getDefault
		return display;
	}
	
	def getImageDescriptor(String name) {
		val u = new URL(bundle.getEntry("/"), name)
		return ImageDescriptor.createFromURL(u);
	}
	
	def getLabelProvider() {
		this.getInjector(ORG_UQBAR_PROJECT_WOLLOK_WOLLOKDSL).getInstance(ILabelProvider)
	}
	
	def getOpener() {
		this.getInjector(ORG_UQBAR_PROJECT_WOLLOK_WOLLOKDSL).getInstance(IURIEditorOpener)
	}

}
