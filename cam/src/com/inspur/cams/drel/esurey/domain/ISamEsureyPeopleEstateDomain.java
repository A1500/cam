package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate;
/**
 * 经济核对_财产收入申报信息domain接口
 * @author 路国隋
 *
 */

public interface ISamEsureyPeopleEstateDomain {
	
	public DataSet query(ParameterSet pset);
	
	@Trans
	public void insert(SamEsureyPeopleEstate dataBean);
	@Trans
	public void update(SamEsureyPeopleEstate dataBean);
	@Trans
	public void delete(String id);
	@Trans
	public void save(List<SamEsureyPeopleEstate> list);
	@Trans
	public void deleteByPeopleId(String peopleId);
	/**
	 * 根据修改信息更新
	 */
	@Trans
	public void upadetPeopleEstate(SamEsureyPeopleEstate samEsureyPeopleEstate);
	 /**
	 * 查询家庭成员的收入
	 * @param paramSet
	 * @return
	 */
	public DataSet queryPeopleIncom(ParameterSet paramSet);
	/**
	 * 查询家庭财产
	 * @param paramSet
	 * @return
	 */
	
	public DataSet queryFamilyWorth(ParameterSet paramSet);
	/**
	 * 查询家庭收入
	 * @param pset
	 * @return
	 */
	public DataSet queryFamilyIncome(ParameterSet pset);
	/**
	 * 社保财产信息
	 * @param peopleId
	 */
	public void getEstateSocial(String peopleId,String familyId);
	/**
	 * 财产信息
	 */
	public void getSamEsureyEstate(SamEsureyPeopleEstate[] Beans,String peopleId,String familyId);
	/**
	 * 房屋财产信息
	 * @param peopleId
	 */
	public void getEsureyHouse(String peopleId,String familyId);
	/**
	 * 车辆财产信息
	 * @param peopleId
	 */
	public void getEsureyCar(String peopleId,String familyId);

	/**
	 * 银行财产信息
	 * @param peopleId
	 */
	public  void getBankEstate(String peopleId,String familyId);
	/**
	 * 有价证券信息
	 * @param peopleId
	 */
	public void getSecuritiesEstate(String peopleId,String familyId);
}
