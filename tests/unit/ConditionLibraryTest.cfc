component extends="testbox.system.BaseSpec" {

	function run() {
		describe( "Condition library", function() {
			beforeEach( body=function(){
				variables._wfId = CreateUUId();
				variables._instanceArgs = {};
				variables._state = { test=CreateUUId() };
				variables._instance = CreateMock( object=new cfflow.models.instances.WorkflowInstance( workflowId=_wfId, instanceArgs=_instanceArgs ) );

				variables._instance.$( "getState", _state );
			} );

			describe( "State", function(){
				describe( "state.exists", function(){
					it( "should return true when the given key exists in the instance's state", function(){
						var condition = new cfflow.models.implementation.conditions.state.Exists();
						var args = { key="test" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();
					} );
					it( "should return false when the given key does not exist in the instance's state", function(){
						var condition = new cfflow.models.implementation.conditions.state.Exists();
						var args = { key="blah" };

						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should return true when or more given keys (array) exist in the state", function(){
						var condition = new cfflow.models.implementation.conditions.state.Exists();
						var args = { key=[ "blah", "blah2", "test" ] };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();
					} );
					it( "should return false when none of the given keys (array) exist in the state", function(){
						var condition = new cfflow.models.implementation.conditions.state.Exists();
						var args = { key=[ "blah", "blah2", "blah3" ] };

						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );

				} );
			} );

			describe( "String", function(){
				describe( "isEqual", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.IsEqual();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="test", pattern="test" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "Test";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "Test", "blah", "test" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "blah2";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
				describe( "isEqualNoCase", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.IsEqualNoCase();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="test", pattern="TEST" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "blah";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "blah", "blah", "tESt" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "blah2";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
				describe( "isGreaterThan", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.IsGreaterThan();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="blah", pattern="atest" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "carrrg";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "zzzar", "zzbl", "arrgkj" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "zz";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
				describe( "isGreaterThanNoCase", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.IsGreaterThanNoCase();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="blah", pattern="atest" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "carrrg";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "zzzar", "zzbl", "arrgkj" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "zz";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
				describe( "isLessThan", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.IsLessThan();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="blah", pattern="ctest" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "arrg";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "aasdfa", "asar", "zzasdf" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "bbasldkjf";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
				describe( "isLessThanNoCase", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.IsLessThanNoCase();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="blah", pattern="ctest" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "arrg";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "aasdfa", "asar", "zzasdf" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "bbasldkjf";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
				describe( "regexMatch", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.RegexMatch();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="blah", pattern="ah$" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "AH$";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "[0-9]+", "\sblah", "est$" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "EST$";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
				describe( "regexMatchNoCase", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.RegexMatchNoCase();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="blah", pattern="AH$" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "sfkj$";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "[0-9]+", "\sblah", "EST$" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "dasdf$";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
				describe( "contains", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.Contains();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="blah", pattern="la" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "LA";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "la", "bal", "es" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "ES";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
				describe( "containsNoCase", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.ContainsNoCase();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="blah", pattern="LA" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "adf";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "la", "bal", "ES" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "sdf";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
				describe( "startsWith", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.StartsWith();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="blah", pattern="bl" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "BL";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "la", "bal", "tes" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "TES";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
				describe( "startsWithNoCase", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.StartsWithNoCase();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="blah", pattern="bL" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "BLr";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "la", "bal", "TES" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "teSla";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
				describe( "endsWith", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.EndsWith();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="blah", pattern="ah" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "AH";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "la", "bal", "est" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "Est";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
				describe( "endsWithNoCase", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.string.EndsWithNoCase();
					} );
					it( "should work on plain input variables", function(){
						var args = { value="blah", pattern="Ah" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern = "sdf";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should work on array input variables", function(){
						var args = { value="test", pattern=[ "la", "bal", "eSt" ] };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.pattern[ 3 ] = "asdfasd";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
				} );
			} );

			describe( "Bool", function(){
				describe( "bool.isTrue", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.bool.IsTrue();
					} );
					it( "should return true when the value is 'true' exactly", function(){
						var args = { value="true" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();
						args.value = true;
						expect( condition.evaluate( _instance, args ) ).toBeTrue();
					} );
					it( "should return false when the value is 'false' exactly", function(){
						var args = { value="false" };

						expect( condition.evaluate( _instance, args ) ).toBeFalse();
						args.value = false;
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should return false when the value is neither 'true' nor 'false' exactly", function(){
						var args = { value=0 };

						expect( condition.evaluate( _instance, args ) ).toBeFalse();

						args.value = 1;
						expect( condition.evaluate( _instance, args ) ).toBeFalse();

						args.value = "yes";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();

						args.value = "no";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );

				} );

				describe( "bool.IsFalse", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.bool.IsFalse();
					} );
					it( "should return true when the value is 'false' exactly", function(){
						var args = { value="false" };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();
						args.value = false;
						expect( condition.evaluate( _instance, args ) ).toBeTrue();
					} );
					it( "should return false when the value is 'true' exactly", function(){
						var args = { value="true" };

						expect( condition.evaluate( _instance, args ) ).toBeFalse();
						args.value = true;
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );
					it( "should return false when the value is neither 'true' nor 'false' exactly", function(){
						var args = { value=0 };

						expect( condition.evaluate( _instance, args ) ).toBeFalse();

						args.value = 1;
						expect( condition.evaluate( _instance, args ) ).toBeFalse();

						args.value = "yes";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();

						args.value = "no";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );

				} );

				describe( "bool.isTruthy", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.bool.IsTruthy();
					} );
					it( "should return true when the value anything like true", function(){
						var args = { value="true" };
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.value = true;
						expect( condition.evaluate( _instance, args ) ).toBeTrue();
						args.value = "yes";
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.value = 1;
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.value = "3";
						expect( condition.evaluate( _instance, args ) ).toBeTrue();
					} );
					it( "should return false when the value is not true", function(){
						var args = { value=0 };

						expect( condition.evaluate( _instance, args ) ).toBeFalse();

						args.value = false;
						expect( condition.evaluate( _instance, args ) ).toBeFalse();

						args.value = "false";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();

						args.value = "no";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();

						args.value = "lksdjflaksjdf";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );

				} );

				describe( "bool.isFalsey", function(){
					beforeEach( function(){
						variables.condition = new cfflow.models.implementation.conditions.bool.IsFalsey();
					} );
					it( "should return true when the value is not truthy", function(){
						var args = { value=0 };

						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.value = false;
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.value = "false";
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.value = "no";
						expect( condition.evaluate( _instance, args ) ).toBeTrue();

						args.value = "lksdjflaksjdf";
						expect( condition.evaluate( _instance, args ) ).toBeTrue();


					} );
					it( "should return false when the value is truthy", function(){
						var args = { value="true" };
						expect( condition.evaluate( _instance, args ) ).toBeFalse();

						args.value = true;
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
						args.value = "yes";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();

						args.value = 1;
						expect( condition.evaluate( _instance, args ) ).toBeFalse();

						args.value = "3";
						expect( condition.evaluate( _instance, args ) ).toBeFalse();
					} );

				} );
			} );
		} );
	}

}