package com.inspur.cams.bpt.capital.excel.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.capital.excel.data.BptImpExcelCapitalTempMark;
import com.inspur.cams.bpt.excelToTable.data.ToTable;

/**
 * 优抚资金发放excel导入domain
 * @author zhanghui
 *
 */
public interface IImpExcelCapitalDomain {

	/**
	 * 查询伤残验证信息
	 * @param pset
	 * @return
	 */
	public DataSet queryDisabilityMark(ParameterSet pset);
	
	/**
	 * 优抚资金发放excel导入临时表
	 * 
	 * @param excelData
	 * @param toTable
	 * @param pset
	 */
	public void importExcel(String[][] excelData, ToTable toTable,
			ParameterSet pset);
	
	
	/**
	 * 资金发放伤残excel导入验证表表级数据验证
	 * 
	 * @param pset
	 */
	public void disablityValidate(ParameterSet pset);
	
	/**
	 *  验证全部身份证号是否为该业务人员
	 * @param pset
	 */
	public void excelIdCardValidateAll(ParameterSet pset);
	
	
	/**
	 * 根据身份证查询该业务人员
	 * @param pset
	 * @return
	 */
	public DataSet excelIdCardValidate(ParameterSet pset);
	
	
	/**
	 * 验证该时期内资金是否已发放
	 */
	public void excelIfGrant(String errorMessage, String viewName,
			ParameterSet pset);
	
	/**
	 * 验证该时期内资金是否已发放
	 */
	public void update(BptImpExcelCapitalTempMark bptImpExcelCapitalTempMark);
	
	/**
	 * 验证某日期资金是否发放
	 * 
	 * @param pset
	 * @return
	 */
	public boolean ifGrant(ParameterSet pset);
	
	/**
	 * 删除资金发放excel导入验证信息表记录
	 * @param id
	 */
	public void delete(String id);
	
	
	/**
	 * 验证该时期内资金是否已发放
	 */
	public DataSet excelIfGrant(ParameterSet pset);
	
	/**
	 * 删除以id_card、register_type分组删除重复数据
	 */
	public void deleteRepeat();
	
	
	/**
	 * 写入数据库
	 */
	public void saveCapital(ParameterSet pset);
	
	/**
	 * 优待金写入数据库
	 * @param pset
	 */
	public void saveCompulsory(ParameterSet pset);
	
}
