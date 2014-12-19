package com.inspur.cams.bpt.capital.excel.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.capital.excel.data.BptImpExcelCapitalTempMark;
import com.inspur.cams.bpt.excelToTable.data.ToTable;

/**
 * 资金发放excel导入dao接口
 * @author zhanghui
 *
 */
@SuppressWarnings("unchecked")
public interface IImpExcelCapitalDao extends BaseCURD<BptImpExcelCapitalTempMark> {

	/**
	 * 优抚资金发放excel导入
	 * @param excelData
	 * @param toTable
	 * @param pset
	 */
	public void importExcel(String[][] excelData,ToTable toTable,ParameterSet pset);
	
	
	/**
	 * 资金发放伤残excel导入临时表表级验证
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
	 * 验证某日期资金是否发放
	 * @param pset
	 * @return
	 */
	public boolean ifGrant(ParameterSet pset);
	
	/**
	 * 删除资金发放excel导入验证信息表记录
	 * @param ids
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
	 * 计算导入数据库发放资金总额
	 * @param pset
	 * @return
	 */
	public DataSet queryGrantMonSum(ParameterSet pset);
	
	/**
	 * 伤残资金发放导入数据库相关信息
	 * @param pset
	 * @return
	 */
	public DataSet queryDisability(ParameterSet pset);
	
	
	/**
	 * 删除某类资金发放excel导入验证信息表记录
	 * @param pset
	 */
	public void delete(ParameterSet pset);
	
	
	/**
	 * 三属资金发放导入数据库相关信息
	 * @param pset
	 * @return
	 */
	public DataSet queryDependant(ParameterSet pset);
	
	/**
	 * 在乡复员资金发放导入数据库相关信息
	 * @param pset
	 * @return
	 */
	public DataSet queryDemobilized(ParameterSet pset);
	
	/**
	 * 带病回乡资金发放导入数据库相关信息
	 * @param pset
	 * @return
	 */
	public DataSet queryDemobilizedIll(ParameterSet pset);
	
	
	/**
	 * 两参资金发放导入数据库相关信息
	 * @param pset
	 * @return
	 */
	public DataSet queryWarAndTested(ParameterSet pset);
	
	
	/**
	 * 优待金导入数据库相关信息
	 * @param pset
	 * @return
	 */
	public DataSet queryCompulsory(ParameterSet pset);
	
	
	 
}
