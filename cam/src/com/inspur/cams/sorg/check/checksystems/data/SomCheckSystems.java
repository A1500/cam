package com.inspur.cams.sorg.check.checksystems.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:内部制度建设情况
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
 */
@Table(tableName = "SOM_CHECK_SYSTEMS", keyFields = "id")
public class SomCheckSystems extends StatefulDatabean {
	// 建设情况主键
	private String id;
	// 业务编号
	private String taskCode;
	// 分支(代表)机构管理制度
	private String ifBranchSys;
	// 法人证书保管、使用管理制度
	private String ifCertSys;
	// 法人证书保管、使用管理制度保管人
	private String certSysManager;
	// 印章保管、使用管理制度
	private String ifStampSys;
	// 印章保管、使用管理制度保管人
	private String stampSysManager;
	// 是否有人事管理制度
	private String ifPersonnalSys;
	// 专职工作人员签订聘用合同人数
	private String contractPersonNum;
	// 专职人员参加失业保险人数
	private String unemploymentInsNum;
	// 专职人员参加养老保险人数
	private String endowmentInsNum;
	// 专职人员参加医疗保险人数
	private String medicalInsNum;
	// 专职人员参加工伤保险人数
	private String injuryInsNum;
	// 专职人员参加生育保险人数
	private String birthInsNum;
	// 人民币开户银行
	private String rmbDepositBank;
	// 人民币银行账号
	private String rmbBankAccounts;
	// 外币开户银行
	private String wbDepositBank;
	// 外币银行账号
	private String wbBankAccounts;
	// 有无财政登记
	private String ifFinancialReg;
	// 税务登记情况
	private String taxRegType;
	// 专职财会人员数
	private String accountantNum;
	// 具有会计执业资格人数
	private String qualificationNum;
	// 使用票据种类
	private String billType;
	// 是否使用了《民间非营利组织财务会计软件》
	private String ifDesignatedSoft;
	// 其他管理制度
	private String otherSys;
	
	private String others;
	public String getOthers() {
		return others;
	}

	public void setOthers(String others) {
		this.others = others;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getIfBranchSys() {
		return ifBranchSys;
	}

	public void setIfBranchSys(String ifBranchSys) {
		this.ifBranchSys = ifBranchSys;
	}

	public String getIfCertSys() {
		return ifCertSys;
	}

	public void setIfCertSys(String ifCertSys) {
		this.ifCertSys = ifCertSys;
	}

	public String getCertSysManager() {
		return certSysManager;
	}

	public void setCertSysManager(String certSysManager) {
		this.certSysManager = certSysManager;
	}

	public String getIfStampSys() {
		return ifStampSys;
	}

	public void setIfStampSys(String ifStampSys) {
		this.ifStampSys = ifStampSys;
	}

	public String getStampSysManager() {
		return stampSysManager;
	}

	public void setStampSysManager(String stampSysManager) {
		this.stampSysManager = stampSysManager;
	}

	public String getIfPersonnalSys() {
		return ifPersonnalSys;
	}

	public void setIfPersonnalSys(String ifPersonnalSys) {
		this.ifPersonnalSys = ifPersonnalSys;
	}

	public String getContractPersonNum() {
		return contractPersonNum;
	}

	public void setContractPersonNum(String contractPersonNum) {
		this.contractPersonNum = contractPersonNum;
	}

	public String getUnemploymentInsNum() {
		return unemploymentInsNum;
	}

	public void setUnemploymentInsNum(String unemploymentInsNum) {
		this.unemploymentInsNum = unemploymentInsNum;
	}

	public String getEndowmentInsNum() {
		return endowmentInsNum;
	}

	public void setEndowmentInsNum(String endowmentInsNum) {
		this.endowmentInsNum = endowmentInsNum;
	}

	public String getMedicalInsNum() {
		return medicalInsNum;
	}

	public void setMedicalInsNum(String medicalInsNum) {
		this.medicalInsNum = medicalInsNum;
	}

	public String getInjuryInsNum() {
		return injuryInsNum;
	}

	public void setInjuryInsNum(String injuryInsNum) {
		this.injuryInsNum = injuryInsNum;
	}

	public String getBirthInsNum() {
		return birthInsNum;
	}

	public void setBirthInsNum(String birthInsNum) {
		this.birthInsNum = birthInsNum;
	}

	public String getRmbDepositBank() {
		return rmbDepositBank;
	}

	public void setRmbDepositBank(String rmbDepositBank) {
		this.rmbDepositBank = rmbDepositBank;
	}

	public String getRmbBankAccounts() {
		return rmbBankAccounts;
	}

	public void setRmbBankAccounts(String rmbBankAccounts) {
		this.rmbBankAccounts = rmbBankAccounts;
	}

	public String getWbDepositBank() {
		return wbDepositBank;
	}

	public void setWbDepositBank(String wbDepositBank) {
		this.wbDepositBank = wbDepositBank;
	}

	public String getWbBankAccounts() {
		return wbBankAccounts;
	}

	public void setWbBankAccounts(String wbBankAccounts) {
		this.wbBankAccounts = wbBankAccounts;
	}

	public String getIfFinancialReg() {
		return ifFinancialReg;
	}

	public void setIfFinancialReg(String ifFinancialReg) {
		this.ifFinancialReg = ifFinancialReg;
	}

	public String getTaxRegType() {
		return taxRegType;
	}

	public void setTaxRegType(String taxRegType) {
		this.taxRegType = taxRegType;
	}

	public String getAccountantNum() {
		return accountantNum;
	}

	public void setAccountantNum(String accountantNum) {
		this.accountantNum = accountantNum;
	}

	public String getQualificationNum() {
		return qualificationNum;
	}

	public void setQualificationNum(String qualificationNum) {
		this.qualificationNum = qualificationNum;
	}

	public String getBillType() {
		return billType;
	}

	public void setBillType(String billType) {
		this.billType = billType;
	}

	public String getIfDesignatedSoft() {
		return ifDesignatedSoft;
	}

	public void setIfDesignatedSoft(String ifDesignatedSoft) {
		this.ifDesignatedSoft = ifDesignatedSoft;
	}

	public String getOtherSys() {
		return otherSys;
	}

	public void setOtherSys(String otherSys) {
		this.otherSys = otherSys;
	}
}