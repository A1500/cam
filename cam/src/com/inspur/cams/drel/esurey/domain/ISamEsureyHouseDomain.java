package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
/**
 * @title:ISamEsureySocialDomain
 * @description:房管domain接口
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
import com.inspur.cams.drel.esurey.data.SamEsureyHouse;

public interface ISamEsureyHouseDomain {
	public DataSet query(ParameterSet pset);

	public void batchDelete(String[] delIds);

	public void update(SamEsureyHouse dataBean);

	public void insert(SamEsureyHouse dataBean);

	public void save(List<SamEsureyHouse> list);
	
	public void delete(String peopleId);
	/**
	 * 保存房屋信息
	 */
	public void getSamEsureyHouse(SamEsureyHouse[] Beans,String peopleId);
	
	public DataSet queryExtHouse(ParameterSet pset);
}
