package com.inspur.cams.fis.ep.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.ep.base.data.FisCemeCheckResult;

/**
 * @title:IFisCemeCheckResultDao
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
 public interface IFisCemeCheckResultDao extends BaseCURD<FisCemeCheckResult>{
	public void save(List<FisCemeCheckResult> list);
	/**
	 * @param checkResult 
	 * @Title: queryForCheckReport 
	 * @Description: TODO(年检结果统计查询) 
	 * @param @param pset
	 * @param @return 设定文件 
	 * @return DataSet    返回类型
	 */
	//public DataSet queryForCheckReport(ParameterSet pset);

	public void reportNoProfitCheck(String wfId, String checkResult);
	public void fullChangeNoProfitCheck(String wfId);
	public void reportProfitFinalCheck(String wfId, String checkResult);
	public void fullChangeProfitFinalCheck(String wfId);
}

