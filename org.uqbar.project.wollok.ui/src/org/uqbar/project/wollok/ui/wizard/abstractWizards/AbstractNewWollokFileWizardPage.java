package org.uqbar.project.wollok.ui.wizard.abstractWizards;

import java.util.Iterator;

import org.eclipse.core.resources.IContainer;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.IAdaptable;
import org.eclipse.core.runtime.Path;
import org.eclipse.jface.dialogs.IDialogPage;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.jface.wizard.WizardPage;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.dialogs.ContainerSelectionDialog;
import org.uqbar.project.wollok.ui.Messages;

/**
 * The abstract parent for all the file wizards. Because all do the same, but it only differes in the extension
 * of the file and the description.
 * @author tesonep
 */
public abstract class AbstractNewWollokFileWizardPage extends WizardPage {

	private Text containerText;
	private Text fileText;
	protected IStructuredSelection selection;

	protected String extension;
	protected String initialFileName;
	protected String title;
	protected String description;
	
	public AbstractNewWollokFileWizardPage(IStructuredSelection selection) {
		super(Messages.AbstractNewWollokFileWizardPage_0);
		this.doInit();
		setTitle(this.title);
		setDescription(this.description);
		this.selection = selection;
	}
	
	protected abstract void doInit();

	public AbstractNewWollokFileWizardPage(String pageName, String title,
			ImageDescriptor titleImage) {
		super(pageName, title, titleImage);
	}

	/**
	 * @see IDialogPage#createControl(Composite)
	 */
	public void createControl(Composite parent) {
		Composite container = new Composite(parent, SWT.NULL);
		GridLayout layout = new GridLayout();
		container.setLayout(layout);
		layout.numColumns = 3;
		layout.verticalSpacing = 9;
		Label label = new Label(container, SWT.NULL);
		label.setText(Messages.AbstractNewWollokFileWizardPage_container);
	
		containerText = new Text(container, SWT.BORDER | SWT.SINGLE);
		GridData gd = new GridData(GridData.FILL_HORIZONTAL);
		containerText.setLayoutData(gd);
		
		containerText.setText(initialContainerValue());
		
		containerText.addModifyListener(new ModifyListener() {
			public void modifyText(ModifyEvent e) {
				dialogChanged();
			}
		});
	
		Button button = new Button(container, SWT.PUSH);
		button.setText(Messages.AbstractNewWollokFileWizardPage_browse);
		button.addSelectionListener(new SelectionAdapter() {
			public void widgetSelected(SelectionEvent e) {
				handleBrowse();
			}
		});
		label = new Label(container, SWT.NULL);
		label.setText(Messages.AbstractNewWollokFileWizardPage_fileName);
	
		fileText = new Text(container, SWT.BORDER | SWT.SINGLE);
		gd = new GridData(GridData.FILL_HORIZONTAL);
		fileText.setLayoutData(gd);
		fileText.addModifyListener(new ModifyListener() {
			public void modifyText(ModifyEvent e) {
				dialogChanged();
			}
		});
		initialize();
		dialogChanged();
		setControl(container);
	}

	/**
	 * Tests if the current workbench selection is a suitable container to use.
	 */
	private void initialize() {
		if (selection != null && selection.isEmpty() == false
				&& selection instanceof IStructuredSelection) {
			IStructuredSelection ssel = (IStructuredSelection) selection;
			if (ssel.size() > 1)
				return;
			Object obj = ssel.getFirstElement();
			if (obj instanceof IResource) {
				IContainer container;
				if (obj instanceof IContainer)
					container = (IContainer) obj;
				else
					container = ((IResource) obj).getParent();
				containerText.setText(container.getFullPath().toString());
			}
		}
		fileText.setText(this.initialFileName);
	}

	/**
	 * Uses the standard container selection dialog to choose the new value for
	 * the container field.
	 */
	private void handleBrowse() {
		ContainerSelectionDialog dialog = new ContainerSelectionDialog(
				getShell(), ResourcesPlugin.getWorkspace().getRoot(), false,
				Messages.AbstractNewWollokFileWizardPage_selectContainer);
		if (dialog.open() == ContainerSelectionDialog.OK) {
			Object[] result = dialog.getResult();
			if (result.length == 1) {
				containerText.setText(((Path) result[0]).toString());
			}
		}
	}

	/**
	 * Ensures that both text fields are set.
	 */
	private void dialogChanged() {
		IResource container = ResourcesPlugin.getWorkspace().getRoot()
				.findMember(new Path(getContainerName()));
		String fileName = getFileName();
	
		if (getContainerName().length() == 0) {
			updateStatus(Messages.AbstractNewWollokFileWizardPage_fileContainerRequired);
			return;
		}
		if (container == null) {
			updateStatus(Messages.AbstractNewWollokFileWizardPage_fileContainerDoesNotExists);
			return;
		}

		if (!container.isAccessible()) {
			updateStatus(Messages.AbstractNewWollokFileWizardPage_projectMustBeWritable);
			return;
		}
		if (fileName.length() == 0) {
			updateStatus(Messages.AbstractNewWollokFileWizardPage_fileNameMustBeSpecified);
			return;
		}
		if (fileName.replace('\\', '/').indexOf('/', 1) > 0) {
			updateStatus(Messages.AbstractNewWollokFileWizardPage_fileNameMustBeValid);
			return;
		}
		int dotLoc = fileName.lastIndexOf('.');
		if (dotLoc != -1) {
			String ext = fileName.substring(dotLoc + 1);
			if (ext.equalsIgnoreCase(this.extension) == false) {
				updateStatus(Messages.AbstractNewWollokFileWizardPage_fileExtensionMustBe + this.extension +"\""); //$NON-NLS-2$
				return;
			}
		}
		updateStatus(null);
	}

	private void updateStatus(String message) {
		setErrorMessage(message);
		setPageComplete(message == null);
	}

	public String getContainerName() {
		return containerText.getText();
	}

	public String getFileName() {
		return fileText.getText();
	}
	
	@SuppressWarnings("rawtypes")
	protected String initialContainerValue() {
			Iterator it = selection.iterator();
			if (it.hasNext()) {
				Object object = it.next();
				IResource selectedResource = null;
				if (object instanceof IResource) {
					selectedResource = (IResource) object;
				} else if (object instanceof IAdaptable) {
					selectedResource = (IResource) ((IAdaptable) object)
							.getAdapter(IResource.class);
				}
				if (selectedResource != null) {
					if (selectedResource.getType() == IResource.FILE) {
						selectedResource = selectedResource.getParent();
					}
					if (selectedResource.isAccessible()) {
						return selectedResource.getFullPath().toString();
					}
				}
			}
			return ""; //$NON-NLS-1$
		}

}