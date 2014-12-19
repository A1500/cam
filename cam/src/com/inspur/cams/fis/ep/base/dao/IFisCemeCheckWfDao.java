package com.inspur.cams.fis.ep.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.ep.base.data.FisCemeCheckWf;


/**
 * @title: IFisCemeCheckWfDao
 * @description:公墓年检流程dao接口
 * @version:1.0
*/
 public interface IFisCemeCheckWfDao extends BaseCURD<FisCemeCheckWf>{
	public void save(List<FisCemeCheckWf> list);

	public void reportNoProfitCheck(String wfId);

	public void fullChangeNoProfitCheck(String wfId);

	public void reportProfitCheck(String wfId);

	public void reportProfitFinalCheck(String wfId);

	public void fullChangeProfitFinalCheck(String wfId);
}

