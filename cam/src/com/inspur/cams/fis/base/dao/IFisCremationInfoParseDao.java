package com.inspur.cams.fis.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisCremationInfoParse;

/**
 * �ϱ����������ѯdao
 * @author 
 * @date 2013-11-07
 */
public interface IFisCremationInfoParseDao extends BaseCURD<FisCremationInfoParse> {

	
	public DataSet queryDs(ParameterSet pset);
}