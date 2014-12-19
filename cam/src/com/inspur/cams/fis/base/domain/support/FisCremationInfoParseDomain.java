package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisCremationInfoParseDao;
import com.inspur.cams.fis.base.data.FisCremationInfoParse;
import com.inspur.cams.fis.base.domain.IFisCremationInfoParseDomain;

/**
 * �ϱ����������ѯdomain
 * @author 
 * @date 2013-11-07
 */
public class FisCremationInfoParseDomain implements IFisCremationInfoParseDomain {

	@Reference
	private IFisCremationInfoParseDao fisCremationInfoParseDao;

	/**
	 * 查询 �ϱ����������ѯ
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisCremationInfoParseDao.query(pset);
	}


	/**
	 * 增加 �ϱ����������ѯ
	 * @param fisCremationInfoParse
	 */
	public void insert(FisCremationInfoParse fisCremationInfoParse) {
		fisCremationInfoParseDao.insert(fisCremationInfoParse);
	}
	
	/**
	 * 修改 �ϱ����������ѯ
	 * @param fisCremationInfoParse
	 */
	public void update(FisCremationInfoParse fisCremationInfoParse) {
		fisCremationInfoParseDao.update(fisCremationInfoParse);
	}
	
	/**
	 * 删除 �ϱ����������ѯ
	 * @param 
	 */
	public void delete(String unitId) {
		fisCremationInfoParseDao.delete(unitId);
	}
	
	
	public DataSet queryDs(ParameterSet pset){
		return fisCremationInfoParseDao.queryDs(pset);
	}

}