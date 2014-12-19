package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisCemeLogoffOpinionDao;
import com.inspur.cams.fis.base.data.FisCemeLogoffOpinion;
import com.inspur.cams.fis.base.domain.IFisCemeLogoffOpinionDomain;

/**
 * 同级其它部门意见domain
 * @author 
 * @date 2013-08-15
 */
public class FisCemeLogoffOpinionDomain implements IFisCemeLogoffOpinionDomain {

	@Reference
	private IFisCemeLogoffOpinionDao fisCemeLogoffOpinionDao;

	/**
	 * 查询 同级其它部门意见
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisCemeLogoffOpinionDao.query(pset);
	}

	/**
	 * 获取 同级其它部门意见
	 * @param pset
	 * @return
	 */
	public FisCemeLogoffOpinion get(String opinionId) {
		return fisCemeLogoffOpinionDao.get(opinionId);
	}

	/**
	 * 增加 同级其它部门意见
	 * @param fisCemeLogoffOpinion
	 */
	public void insert(FisCemeLogoffOpinion fisCemeLogoffOpinion) {
		fisCemeLogoffOpinionDao.insert(fisCemeLogoffOpinion);
	}
	
	/**
	 * 修改 同级其它部门意见
	 * @param fisCemeLogoffOpinion
	 */
	public void update(FisCemeLogoffOpinion fisCemeLogoffOpinion) {
		fisCemeLogoffOpinionDao.update(fisCemeLogoffOpinion);
	}
	
	/**
	 * 删除 同级其它部门意见
	 * @param opinionId
	 */
	public void delete(String opinionId) {
		fisCemeLogoffOpinionDao.delete(opinionId);
	}

}