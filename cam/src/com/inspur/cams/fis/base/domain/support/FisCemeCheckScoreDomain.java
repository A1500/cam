package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisCemeCheckScoreDao;
import com.inspur.cams.fis.base.data.FisCemeCheckScore;
import com.inspur.cams.fis.base.domain.IFisCemeCheckScoreDomain;

/**
 * 公墓年检打分domain
 * @author 
 * @date 2013-08-01
 */
public class FisCemeCheckScoreDomain implements IFisCemeCheckScoreDomain {

	@Reference
	private IFisCemeCheckScoreDao fisCemeCheckScoreDao;

	/**
	 * 查询 公墓年检打分
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisCemeCheckScoreDao.query(pset);
	}

	/**
	 * 获取 公墓年检打分
	 * @param pset
	 * @return
	 */
	public FisCemeCheckScore get(String scoreId) {
		return fisCemeCheckScoreDao.get(scoreId);
	}

	/**
	 * 增加 公墓年检打分
	 * @param fisCemeCheckScore
	 */
	public void insert(FisCemeCheckScore fisCemeCheckScore) {
		fisCemeCheckScoreDao.insert(fisCemeCheckScore);
	}
	
	/**
	 * 修改 公墓年检打分
	 * @param fisCemeCheckScore
	 */
	public void update(FisCemeCheckScore fisCemeCheckScore) {
		fisCemeCheckScoreDao.update(fisCemeCheckScore);
	}
	
	/**
	 * 删除 公墓年检打分
	 * @param scoreId
	 */
	public void delete(String scoreId) {
		fisCemeCheckScoreDao.delete(scoreId);
	}
	public DataSet queryScore(ParameterSet pset) {
		return fisCemeCheckScoreDao.query(pset);
	}
	public void insertAll(FisCemeCheckScore fisCemeCheckScore){
		fisCemeCheckScoreDao.insert(fisCemeCheckScore);
	}
}