package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
/**
 * @title:ISamEsureySecuritiesDomain
 * @description:房管domain接口
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
import com.inspur.cams.drel.esurey.data.SamEsureySecurities;

public interface ISamEsureySecuritiesDomain {
	public DataSet query(ParameterSet pset);

	public void batchDelete(String[] delIds);

	public void update(SamEsureySecurities dataBean);

	public void insert(SamEsureySecurities dataBean);

	public void save(List<SamEsureySecurities> list);
	public void delete(String peopleId);
	/*
	 * 证监信息
	 */
	public void getEsureySecurities(SamEsureySecurities[] Beans,String peopleId);
	public DataSet queryExtSecurities(ParameterSet pset);
}
