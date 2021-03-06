package org.uqbar.project.wollok.ui.diagrams.classes.parts

import java.beans.PropertyChangeEvent
import java.beans.PropertyChangeListener
import org.eclipse.draw2d.ChopboxAnchor
import org.eclipse.draw2d.ConnectionAnchor
import org.eclipse.draw2d.geometry.Dimension
import org.eclipse.gef.ConnectionEditPart
import org.eclipse.gef.EditPart
import org.eclipse.gef.EditPolicy
import org.eclipse.gef.GraphicalEditPart
import org.eclipse.gef.NodeEditPart
import org.eclipse.gef.Request
import org.eclipse.gef.editpolicies.ComponentEditPolicy
import org.eclipse.gef.editpolicies.FlowLayoutEditPolicy
import org.eclipse.gef.requests.CreateRequest
import org.uqbar.project.wollok.ui.diagrams.classes.model.Shape

/**
 * Abstract base class for edit parts for (named) objects and classes
 * which share some common behavior.
 * 
 * @author jfernandes
 */
abstract class AbstractMethodContainerEditPart extends AbstractLanguageElementEditPart implements PropertyChangeListener, NodeEditPart {
	ConnectionAnchor anchor

	def Shape getCastedModel()

	override activate() {
		if (!active) {
			super.activate
			castedModel.size = max(figure.preferredSize, (100 -> 0))
			castedModel.addPropertyChangeListener(this)
		}
	}
	
	def static max(Dimension d, Pair<Integer, Integer> other) {
		new Dimension(Math.max(d.width, other.key), Math.max(d.height, other.value))
	}
	
	override deactivate() {
		if (active) {
			super.deactivate
			castedModel.removePropertyChangeListener(this)
		}
	}
	
		def getConnectionAnchor() {
		if (anchor == null)
			anchor = new ChopboxAnchor(figure)
		anchor
	}
	
	override createEditPolicies() {
		installEditPolicy(EditPolicy.COMPONENT_ROLE, new ComponentEditPolicy {})
		installEditPolicy(EditPolicy.CONTAINER_ROLE, new ClassContainerEditPolicy)
		// to be able to select child parts
		installEditPolicy(EditPolicy.LAYOUT_ROLE, new FlowLayoutEditPolicy {
			override protected createAddCommand(EditPart arg0, EditPart arg1) {}
			override protected createMoveChildCommand(EditPart arg0, EditPart arg1) {}
			override protected getCreateCommand(CreateRequest arg0) {}
		})
	}
	
	override getModelSourceConnections() { castedModel.sourceConnections }
	override getModelTargetConnections() { castedModel.targetConnections }
	override getSourceConnectionAnchor(ConnectionEditPart connection) { connectionAnchor }
	override getSourceConnectionAnchor(Request request) { connectionAnchor }
	override getTargetConnectionAnchor(ConnectionEditPart connection) { connectionAnchor }
	override getTargetConnectionAnchor(Request request) { connectionAnchor }

	override propertyChange(PropertyChangeEvent evt) {
		val prop = evt.propertyName
		if (Shape.SIZE_PROP == prop || Shape.LOCATION_PROP == prop)
			refreshVisuals
		else if (Shape.SOURCE_CONNECTIONS_PROP == prop)
			refreshSourceConnections
		else if (Shape.TARGET_CONNECTIONS_PROP == prop)
			refreshTargetConnections
	}

	override refreshVisuals() {
		(parent as GraphicalEditPart).setLayoutConstraint(this, figure, castedModel.bounds)
	}
	
}