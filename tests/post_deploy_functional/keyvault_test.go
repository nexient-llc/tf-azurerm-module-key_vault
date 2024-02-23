package tests

import (
	"fmt"
	"os"
	"path"
	"testing"

	"github.com/gruntwork-io/go-commons/files"
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/suite"
)

// Define the suite, and absorb the built-in basic suite
// functionality from testify - including a T() method which
// returns the current testing context
type TerraTestSuite struct {
	suite.Suite
	TerraformOptions *terraform.Options
	suiteSetupDone   bool
}

// setup to do before any test runs
func (suite *TerraTestSuite) SetupSuite() {
	// Ensure that the destroy method is called even if the apply fails
	defer func() {
		fmt.Println("Entering ")
		if !suite.suiteSetupDone {
			terraform.Destroy(suite.T(), suite.TerraformOptions)
		}
	}()
	tmpDir := test_structure.CopyTerraformFolderToTemp(suite.T(), "../..", ".")
	_ = files.CopyFile(path.Join("..", "..", ".tool-versions"), path.Join(tmpDir, ".tool-versions"))
	cwd, err := os.Getwd()
	if err != nil {
		suite.T().Fatal(err)
	}
	suite.TerraformOptions = terraform.WithDefaultRetryableErrors(suite.T(), &terraform.Options{
		TerraformDir: tmpDir,
		VarFiles:     []string{path.Join(cwd, "..", "test.tfvars")},
	})
	terraform.InitAndApplyAndIdempotent(suite.T(), suite.TerraformOptions)
	suite.suiteSetupDone = true
}

// TearDownAllSuite has a TearDownSuite method, which will run after all the tests in the suite have been run.
func (suite *TerraTestSuite) TearDownSuite() {
	terraform.Destroy(suite.T(), suite.TerraformOptions)
}

// In order for 'go test' to run this suite, we need to create
// a normal test function and pass our suite to suite.Run
func TestRunSuite(t *testing.T) {
	suite.Run(t, new(TerraTestSuite))
}

func (suite *TerraTestSuite) TestKeyVault() {
	// NOTE: "subscriptionID" is overridden by the environment variable "ARM_SUBSCRIPTION_ID". <>
	subscriptionID := ""

	expected_key_vault_name := "deb-test-akv-000"
	expected_rg_name := "deb-test-devops"

	key_vault_name := terraform.Output(suite.T(), suite.TerraformOptions, "key_vault_name")
	keyVault := azure.GetKeyVault(suite.T(), expected_rg_name, expected_key_vault_name, subscriptionID)
	suite.NotEmpty(*keyVault, "Key Vault should not be empty")
	suite.Equal(expected_key_vault_name, key_vault_name, "Names should match")

}
