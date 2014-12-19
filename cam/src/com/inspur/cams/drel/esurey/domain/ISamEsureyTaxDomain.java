package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
/**
 * @title:ISamEsureyTaxDomain
 * @description:国税domain接口
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
import com.inspur.cams.drel.esurey.data.SamEsureyTax;

public interface ISamEsureyTaxDomain {
	public DataSet query(ParameterSet pset);

	public void batchDelete(String[] delIds);

	public void update(SamEsureyTax dataBean);

	public void insert(SamEsureyTax dataBean);

	public void save(List<SamEsureyTax> list);
	
	public void delete(String peopleId);
	/*
	 * 国税信息
	 */
	public void getEsureyTaxG(SamEsureyTax[] Beans,String peopleId);
	/*
	 * 地税信息
	 */
	public void getEsureyTaxD(SamEsureyTax[] Beans,String peopleId);
	public DataSet queryGExtTax(ParameterSet pset);
	public DataSet queryDExtTax(ParameterSet pset);
	
}
