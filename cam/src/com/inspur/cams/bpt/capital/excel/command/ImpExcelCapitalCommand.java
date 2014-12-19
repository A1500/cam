package com.inspur.cams.bpt.capital.excel.command;

import java.io.InputStream;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.capital.excel.data.BptImpExcelCapitalTempMark;
import com.inspur.cams.bpt.capital.excel.domain.IImpExcelCapitalDomain;
import com.inspur.cams.bpt.excelToTable.ReadExcel;
import com.inspur.cams.bpt.excelToTable.ReadXML;
import com.inspur.cams.bpt.excelToTable.data.ToTable;

/**
 * 优抚资金发放excel导入command
 * 
 * @author zhanghui
 * 
 */
public class ImpExcelCapitalCommand extends BaseAjaxCommand {

	private IImpExcelCapitalDomain impExcelCapitalService = ScaComponentFactory
			.getService(IImpExcelCapitalDomain.class,
					"ImpExcepCapitalDomain/ImpExcepCapitalDomain");

	/**
	 * 导入excel
	 */
	@Trans
	public void importExcel() {

		ParameterSet pset = getParameterSet();
		String xml_Name = "imp_capital_dependant.xml";
		String registerType = (String) pset.getParameter("registerType");
		int startRows = 2;
		if ("11".equals(registerType)) {
			xml_Name = "imp_capital_disbility.xml";
		}  else if ("00".equals(registerType)) {
			startRows = 1;
			xml_Name = "imp_compulsory.xml";
		}

		String xml_path = ImpExcelCapitalCommand.class.getResource(
				"../xml/" + xml_Name).getPath(); // xml配置路径
		InputStream is = null;
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		UploadFile uploadfile = wrapRequest.getUploadFile("file");
		try {
			is = uploadfile.getInputStream();
			String[][] excelData = ReadExcel.readExcelUtil(is, startRows, 1);
			ToTable toTable = ReadXML.parserXmlUtil(xml_path);
			impExcelCapitalService.importExcel(excelData, toTable, pset); // 插入临时表和验证表
			impExcelCapitalService.deleteRepeat(); // 删除重复数据
			// impExcelCapitalService.disablityValidate(pset); //验证表数据表级验证
			impExcelCapitalService.excelIdCardValidateAll(pset); // 验证是否为该业务人员
			/*
			 * impExcelCapitalService.excelIfGrant("该时期资金已发放",
			 * "v_bpt_people_disability", pset); // 验证该时期资金是否已发放
			 */
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // 关闭is流
			try {
				if (null != is) {
					is.close();
					is = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * 修改资金发放excel导入验证表信息
	 */
	@Trans
	public void update() {
		Record records = (Record) getParameter("record");
		BptImpExcelCapitalTempMark bean = (BptImpExcelCapitalTempMark) records
				.toBean(BptImpExcelCapitalTempMark.class);

		bean.setValidateFlag("0");
		bean.setErrorMessage("");
		impExcelCapitalService.update(bean);
	}

	/**
	 * 验证是否已发放
	 */
	public void validateIfGrant() {
		ParameterSet pset = getParameterSet();
		this.setReturn("ifGrant", impExcelCapitalService.ifGrant(pset));
	}

	/**
	 * 删除资金发放excel导入的验证信息
	 */
	@Trans
	public void delete() {
		Record[] records = (Record[]) getParameter("records");
		for (Record record : records) {
			impExcelCapitalService.delete((String) record.get("id"));
		}
	}

	/**
	 * 入库前检验数据是否通过验证
	 */
	public void validateCommit() {
		boolean result = true;
		ParameterSet pset = getParameterSet();
		DataSet ds = impExcelCapitalService.queryDisabilityMark(pset);
		if (ds.getCount() != 0) {
			Record record;
			for (int i = 0; i < ds.getCount(); i++) {
				record = ds.getRecord(i);
				if ("1".equals((String) record.get("validateFlag"))) {
					result = false;
					break;
				}
			}
			this.setReturn("validate", result);
		}
	}

	/**
	 * 写入数据库验证前验证是否已发放
	 * 
	 * @return
	 */
	public void impValidate() {
		ParameterSet pset = getParameterSet();
		this.setReturn("validate", impExcelCapitalService.excelIfGrant(pset)
				.getCount() > 0);
	}

	/**
	 * 写入数据库
	 */
	@Trans
	public void saveCapital() {
		ParameterSet pset = getParameterSet();
		String registerType = (String)pset.getParameter("REGISTER_TYPE");
		if("00".equals(registerType)) {
			impExcelCapitalService.saveCompulsory(pset);
		} else {
			impExcelCapitalService.saveCapital(pset);
		}
	}

	/**
	 * 验证身份证是否为该业务人员
	 */
	public void updateValidateIdcard() {
		ParameterSet pset = getParameterSet();
		this.setReturn("validate", impExcelCapitalService.excelIdCardValidate(
				pset).getCount() > 0);

	}

	/**
	 * 验证在某优抚对象中是否已存在该人的信息
	 */
	public void ifRepeat() {
		ParameterSet pset = getParameterSet();
		this.setReturn("ifRepeat", impExcelCapitalService.queryDisabilityMark(
				pset).getCount() > 0);

	}
}
