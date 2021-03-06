/*
  |----------------------------------------------------------------------------------------------|
	| Parameter  | Required | Type    | Default | Description                                      |
  |----------------------------------------------------------------------------------------------|
	| name       | Yes      | string  |         | table name, in pluralized form                   |
	| force      | No       | boolean | false   | drop existing table of same name before creating |
	| id         | No       | boolean | true    | if false, defines a table with no primary key    |
	| primaryKey | No       | string  | id      | overrides default primary key name               |
  |----------------------------------------------------------------------------------------------|

    EXAMPLE:
      t = createTable(name='employees', force=false, id=true, primaryKey='empId');
			t.string(columnNames='firstName,lastName', default='', null=true, limit='255');
			t.text(columnNames='bio', default='', null=true);
			t.binary(columnNames='credentials');
			t.biginteger(columnNames='sinsCommitted', default='', null=true, limit='1');
			t.char(columnNames='code', default='', null=true, limit='8');
			t.decimal(columnNames='hourlyWage', default='', null=true, precision='1', scale='2');
			t.date(columnNames='dateOfBirth', default='', null=true);
			t.datetime(columnNames='employmentStarted', default='', null=true);
			t.float(columnNames='height', default='', null=true);
			t.integer(columnNames='age', default='', null=true, limit='1');
      t.time(columnNames='lunchStarts', default='', null=true);
			t.uniqueidentifier(columnNames='uid', default='newid()', null=false);
			t.references("vacation");
			t.timestamps();
			t.create();
*/
component extends="wheels.migrator.Migration" hint="Creates Mpages Table" {

	function up() {
		transaction {
			try {
			t = createTable(name='mpages');
					t.string(columnNames="name", null=false, limit='45');
					t.string(columnName="headerImage", null=true, limit="200");
					t.string(columnNames="metaAuthor", null=true, limit='45');
					t.string(columnNames="metaKeywords", null=true, limit='160');
					t.string(columnNames="metaDescription", null=true, limit="160");
					t.string(columnNames="excerpt", null=true, limit=250);
					t.text(columnNames="content", null=true);
					t.text(columnNames="options,value,docs", default='', null=true );
					t.boolean(columnNames='pageStatus', default=false);
				t.boolean(columnNames="editable", default=true);
				t.timestamps();
				t.create();
			} catch (any e) {
				local.exception = e;
			}

			if (StructKeyExists(local, "exception")) {
				transaction action="rollback";
				throw(errorCode="1", detail=local.exception.detail, message=local.exception.message, type="any");
			} else {
				transaction action="commit";
			}
		}
	}

	function down() {
		transaction {
			try {
				dropTable('mpages');
			} catch (any e) {
				local.exception = e;
			}

			if (StructKeyExists(local, "exception")) {
				transaction action="rollback";
				throw(errorCode="1", detail=local.exception.detail, message=local.exception.message, type="any");
			} else {
				transaction action="commit";
			}
		}
	}

}
