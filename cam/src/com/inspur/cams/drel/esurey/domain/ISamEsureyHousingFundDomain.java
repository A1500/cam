package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
/**
 * @title:ISamEsureyHousingFundDomain
 * @description:公积金domain接口
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
import com.inspur.cams.drel.esurey.data.SamEsureyHousingFund;

public interface ISamEsureyHousingFundDomain {
	public DataSet query(ParameterSet pset);

	public void batchDelete(String[] delIds);

	public void update(SamEsureyHousingFund dataBean);

	public void insert(SamEsureyHousingFund dataBean);

	public void save(List<SamEsureyHousingFund> list);
	
	public void delete(String peopleId);
	/*
	 * 公积金信息
	 */
	public void getEsureyFund(SamEsureyHousingFund[] Beans,String peopleId);
	
	public DataSet queryExtHousingFund(ParameterSet pset);
}
