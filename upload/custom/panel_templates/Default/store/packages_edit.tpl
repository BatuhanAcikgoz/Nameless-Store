{include file='header.tpl'}
<body class="hold-transition sidebar-mini">
<div class="wrapper">
    {include file='navbar.tpl'}
    {include file='sidebar.tpl'}

    <div class="content-wrapper">
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">{$PACKAGES}</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="{$PANEL_INDEX}">{$DASHBOARD}</a></li>
                            <li class="breadcrumb-item active">{$STORE}</li>
                            <li class="breadcrumb-item active">{$PACKAGES}</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                {if isset($NEW_UPDATE)}
                {if $NEW_UPDATE_URGENT eq true}
                <div class="alert alert-danger">
                    {else}
                    <div class="alert alert-primary alert-dismissible" id="updateAlert">
                        <button type="button" class="close" id="closeUpdate" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        {/if}
                        {$NEW_UPDATE}
                        <br />
                        <a href="{$UPDATE_LINK}" class="btn btn-primary" style="text-decoration:none">{$UPDATE}</a>
                        <hr />
                        {$CURRENT_VERSION}<br />
                        {$NEW_VERSION}
                    </div>
                    {/if}

                    <div class="card">
                        <div class="card-body">
                            <h5 style="display:inline">{$EDITING_PACKAGE}</h5>
                            <div class="float-md-right">
                                <a href="/panel/store/packages" class="btn btn-primary">{$BACK}</a>
                            </div>
                            <hr />

                            {if isset($SUCCESS)}
                                <div class="alert alert-success alert-dismissible">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h5><i class="icon fa fa-check"></i> {$SUCCESS_TITLE}</h5>
                                    {$SUCCESS}
                                </div>
                            {/if}

                            {if isset($ERRORS) && count($ERRORS)}
                                <div class="alert alert-danger alert-dismissible">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h5><i class="icon fas fa-exclamation-triangle"></i> {$ERRORS_TITLE}</h5>
                                    <ul>
                                        {foreach from=$ERRORS item=error}
                                            <li>{$error}</li>
                                        {/foreach}
                                    </ul>
                                </div>
                            {/if}
							
                            <form action="" method="post">
								<div class="form-group">
									<label for="InputName">{$PACKAGE_NAME}</label>
									<input type="text" name="name" class="form-control" id="InputName" value="{$PACKAGE_NAME_VALUE}" placeholder="{$PACKAGE_NAME}">
								</div>
								<div class="form-group">
                                    <strong><label for="inputDescription">{$PACKAGE_DESCRIPTION}</label></strong>
                                    <textarea id="inputDescription" name="description">{$PACKAGE_DESCRIPTION_VALUE}</textarea>
                                </div>
								<div class="form-group">
									<div class="row">
                                        <div class="col-md-6">
											<label for="inputPrice">{$PRICE}</label>
											<div class="input-group">
												<input type="number" name="price" class="form-control" id="inputPrice" step="0.01" min="0.01" value="{$PACKAGE_PRICE_VALUE}" placeholder="{$PRICE}">
												<div class="input-group-append">
													<span class="input-group-text">{$CURRENCY}</span>
												</div>
											</div>
										</div>
                                        <div class="col-md-6">
											<label for="inputCategory">{$CATEGORY}</label>
											<select name="category" class="form-control" id="inputCategory">
												{foreach from=$CATEGORY_LIST item=category}
												<option value="{$category.id}" {if $PACKAGE_CATEGORY_VALUE == {$category.id}} selected{/if}>{$category.name}</option>
												{/foreach}
											</select>
										</div>
                                    </div>
								</div>
                                <div class="form-group">
                                    <input type="hidden" name="token" value="{$TOKEN}">
                                    <input type="submit" class="btn btn-primary" value="{$SUBMIT}">
                                </div>
                            </form>
							
							</br>
							
							<h5 style="display:inline">{$COMMANDS}</h5>
							<div class="float-md-right">
								<a href="/panel/store/packages/?action=new_command&id={$ID}" class="btn btn-primary">{$NEW_COMMAND}</a>
							</div>
							
							{if count($COMMAND_LIST)}
							<div class="table-responsive">
                                <table class="table">
									<thead>
										<tr>
											<th>Trigger On</th>
											<th>Require the player to be online</th>
											<th>Command (Without /)</th>
											<th></th>
										</tr>
									</thead>
                                    <tbody id="sortable">
									{foreach from=$COMMAND_LIST item=command}
										<tr data-id="{$command.id}">
											<td>{$command.type}</td>
											<td>{$command.requirePlayer}</td>
											<td>{$command.command}</td>
											<td>
												<div class="float-md-right">
													<a class="btn btn-warning btn-sm" href="/panel/store/packages/?action=edit_command&id={$ID}&command={$command.id}"><i class="fas fa-edit fa-fw"></i></a>
													<a class="btn btn-danger btn-sm" href="/panel/store/packages/?action=delete_command&id={$ID}&command={$command.id}"><i class="fas fa-trash fa-fw"></i></a>
												</div>
											</td>
										</tr>
									{/foreach}
									</tbody>
                                </table>
                            </div>
							{else}
							<hr>
							There are no commands yet.
							</br></br>
							{/if}

                            <!--<form action="" method="post" enctype="multipart/form-data">
                                <div class="form-group">
                                    <strong>{$PACKAGE_IMAGE}</strong><br />
                                    {if $PACKAGE_IMAGE_VALUE}
                                        <img src="{$PACKAGE_IMAGE_VALUE}" alt="{$PACKAGE_NAME}" style="max-height:200px;max-width:200px;"><br />
                                    {/if}
                                    <strong>{$UPLOAD_NEW_IMAGE}</strong><br />
                                    <label class="btn btn-secondary">
                                        {$BROWSE} <input type="file" name="store_image" hidden/>
                                    </label>
                                </div>
                                <div class="form-group">
                                    <input type="hidden" name="token" value="{$TOKEN}">
                                    <input type="hidden" name="type" value="image">
                                    <input type="submit" value="{$SUBMIT}" class="btn btn-primary">
                                </div>
                            </form>-->

                        </div>
                    </div>

                    <!-- Spacing -->
                    <div style="height:1rem;"></div>

                </div>
        </section>
    </div>

    {include file='footer.tpl'}

</div>
<!-- ./wrapper -->

{include file='scripts.tpl'}

</body>
</html>