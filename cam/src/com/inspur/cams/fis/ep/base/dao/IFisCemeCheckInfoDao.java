package com.inspur.cams.fis.ep.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.ep.base.data.FisCemeCheckInfo;


/**
 * @title: IFisCemeCheckInfoDao
 * @description:公墓年检表单dao接口
 * @author:lidongdong
 * @since:2011-11-17
 * @version:1.0
*/
 public interface IFisCemeCheckInfoDao extends BaseCURD<FisCemeCheckInfo>{
	public void save(List<FisCemeCheckInfo> list);
	public DataSet queryForCemeInfo(ParameterSet pset);
	public void reportNoProfitCheck(String endApplyId);
	public void reportProfitCheck(String endApplyId);
	public void reportProfitFinalCheck(String endApplyId);
}

