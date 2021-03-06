package wollok.lang

import org.uqbar.project.wollok.interpreter.WollokInterpreter
import org.uqbar.project.wollok.interpreter.WollokRuntimeException
import org.uqbar.project.wollok.interpreter.core.WollokObject
import org.uqbar.project.wollok.interpreter.nativeobj.NativeMessage

/**
 * Native implementation of the string wollok class
 * 
 * @author jfernandes
 */
class WString extends AbstractJavaWrapper<String> {
	new(WollokObject obj, WollokInterpreter interpreter) {
		super(obj, interpreter)
	}

	def length() { wrapped.length }
	
	def charAt(Integer index) {}
	@NativeMessage("+")
	def concat(Object other) { doConcatWith(other) }
		def dispatch WollokObject doConcatWith(WString o) { newInstanceWithWrapped(this.wrapped + o.wrapped) }
		def dispatch WollokObject doConcatWith(WollokObject it) { asWString.doConcatWith }
		
	def startsWith(WollokObject other) { wrapped.startsWith(other.asWString.wrapped) }
	def endsWith(WollokObject other ) { wrapped.endsWith(other.asWString.wrapped) }
	def indexOf(WollokObject other) { wrapped.indexOf(other.asWString.wrapped) }
	def lastIndexOf(WollokObject other ) { wrapped.lastIndexOf(other.asWString.wrapped) }
	def toLowerCase() { wrapped.toLowerCase }
	def toUpperCase() { wrapped.toUpperCase }
	def trim() { wrapped.trim }
	def substring(Integer length) { wrapped.substring(length) }
	def substring(Integer startIndex, Integer length ) { wrapped.substring(startIndex, length) }
	
	@NativeMessage("toString")
	def wollokToString() { wrapped.toString }
	def toSmartString(Object alreadyShown) { wollokToString }
	
	@NativeMessage("==")
	def wollokEquals(WollokObject other) {
		val wString = other.getNativeObject(WString)
		wString != null && wrapped == wString.wrapped
	}
	
	def asWString(WollokObject it) { 
		val wString = it.getNativeObject(WString)
		if (wString == null) throw new WollokRuntimeException("Expecting object to be a string: " + it)
		wString
	}
}