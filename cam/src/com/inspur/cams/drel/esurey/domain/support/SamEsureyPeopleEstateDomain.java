package com.inspur.cams.drel.esurey.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.dao.ISamEsureyBankDao;
import com.inspur.cams.drel.esurey.dao.ISamEsureyCarDao;
import com.inspur.cams.drel.esurey.dao.ISamEsureyHouseDao;
import com.inspur.cams.drel.esurey.dao.ISamEsureyPeopleEstateDao;
import com.inspur.cams.drel.esurey.dao.ISamEsureySecuritiesDao;
import com.inspur.cams.drel.esurey.dao.ISamEsureySocialDao;
import com.inspur.cams.drel.esurey.data.SamEsureyBank;
import com.inspur.cams.drel.esurey.data.SamEsureyCar;
import com.inspur.cams.drel.esurey.data.SamEsureyHouse;
import com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate;
import com.inspur.cams.drel.esurey.data.SamEsureySecurities;
import com.inspur.cams.drel.esurey.data.SamEsureySocial;
import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleEstateDomain;
/**
 * 经济核对_财产收入申报信息domain实现
 * @author 路国隋
 *
 */
public class SamEsureyPeopleEstateDomain implements ISamEsureyPeopleEstateDomain{

	@Reference
	private ISamEsureyPeopleEstateDao samEsureyPeopleEstateDao;
	@Reference
	private ISamEsureySocialDao samEsureySocialDao;
	@Reference
	private ISamEsureyHouseDao samEsureyHouseDao;
	@Reference
	private ISamEsureyCarDao samEsureyCarDao;
	@Reference
	private ISamEsureyBankDao samEsureyBankDao;
	@Reference
	private ISamEsureySecuritiesDao samEsureySecuritiesDao;
	
	public void insert(SamEsureyPeopleEstate dataBean) {
		samEsureyPeopleEstateDao.insert(dataBean);
	}

	public DataSet query(ParameterSet pset) {
		return samEsureyPeopleEstateDao.query(pset);
	}

	public void update(SamEsureyPeopleEstate dataBean) {
		samEsureyPeopleEstateDao.update(dataBean);
	}

	public void delete(String id) {
		samEsureyPeopleEstateDao.deleteById(id);
	}
	public void save(List<SamEsureyPeopleEstate> list){
		samEsureyPeopleEstateDao.save(list);
	}
	public void deleteByPeopleId(String peopleId){
		samEsureyPeopleEstateDao.delete(peopleId);
	}
	/**
	 * 根据修改信息更新
	 */
	public void upadetPeopleEstate(SamEsureyPeopleEstate samEsureyPeopleEstate) {
		// TODO Auto-generated method stub
		samEsureyPeopleEstateDao.upadetPeopleEstate(samEsureyPeopleEstate);
	}
	 /**
	 * 查询家庭成员的收入
	 * @param paramSet
	 * @return
	 */
	public DataSet queryPeopleIncom(ParameterSet paramSet) {
		return samEsureyPeopleEstateDao.queryPeopleIncom(paramSet);
	}
	/**
	 * 查询家庭财产
	 * @param paramSet
	 * @return
	 */
	public DataSet queryFamilyWorth(ParameterSet paramSet) {
		
		return samEsureyPeopleEstateDao.queryFamilyWorth(paramSet);
	}
	/**
	 * 查询家庭收入
	 * @param pset
	 * @return
	 */
	public DataSet queryFamilyIncome(ParameterSet pset){
		return samEsureyPeopleEstateDao.queryFamilyIncome(pset);
	}
	/**
	 * 社保财产信息
	 * @param peopleId
	 */
	public void getEstateSocial(String peopleId,String familyId){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		pset.setParameter("TYPE", "1");
		int isFlag=samEsureySocialDao.query(pset).getCount();
		if(isFlag!=0){
		SamEsureySocial bean=(SamEsureySocial)samEsureySocialDao.query(pset).getRecord(0).toBean(SamEsureySocial.class);
		List<SamEsureyPeopleEstate> soList=new ArrayList<SamEsureyPeopleEstate>();
		SamEsureyPeopleEstate estateBean=new SamEsureyPeopleEstate();		
		String id=IdHelp.getUUID30();
		estateBean.setId(id);
		estateBean.setPeopleId(peopleId);
		estateBean.setFamilyId(familyId);
		estateBean.setType("1");
		estateBean.setPeriod(bean.getYearMonth());
		estateBean.setItem("8");
		estateBean.setNum(bean.getSalary());
		soList.add(estateBean);
		samEsureyPeopleEstateDao.save(soList);
		}
	}
	/**
	 * 财产信息
	 */
	public void getSamEsureyEstate(SamEsureyPeopleEstate[] Beans,String peopleId,String familyId){
		List<SamEsureyPeopleEstate> soList=new ArrayList<SamEsureyPeopleEstate>();
		for(int i=0;i<Beans.length;i++){
			SamEsureyPeopleEstate bean=Beans[i];
			if(Beans[i].getState()==Record.STATE_NEW){
				String id=IdHelp.getUUID30();
				bean.setId(id);
				bean.setPeopleId(peopleId);
				bean.setFamilyId(familyId);
				bean.setType("1");
			}else if(Beans[i].getState()==Record.STATE_MODIFIED){
				samEsureyPeopleEstateDao.update(bean);
			}		
			soList.add(bean);
		}
		samEsureyPeopleEstateDao.save(soList);
	}	
	/**
	 * 房屋财产信息
	 * @param peopleId
	 */
	public void getEsureyHouse(String peopleId,String familyId){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		pset.setParameter("TYPE", "1");
		int num=samEsureyHouseDao.query(pset).getCount();
		if(num!=0){
		float values=0;
		for(int i=0;i<num;i++){
			SamEsureyHouse bean=(SamEsureyHouse)samEsureyHouseDao.query(pset).getRecord(i).toBean(SamEsureyHouse.class);
			values=values+Float.parseFloat(bean.getRegValue());
		}		
		List<SamEsureyPeopleEstate> soList=new ArrayList<SamEsureyPeopleEstate>();
		SamEsureyPeopleEstate estateBean=new SamEsureyPeopleEstate();		
		String id=IdHelp.getUUID30();
		estateBean.setId(id);
		estateBean.setPeopleId(peopleId);
		estateBean.setFamilyId(familyId);
		estateBean.setType("1");
		estateBean.setItem("5");
		estateBean.setNum(Float.toString(values));
		soList.add(estateBean);
		samEsureyPeopleEstateDao.save(soList);
		}
	}
	/**
	 * 车辆财产信息
	 * @param peopleId
	 */
	public void getEsureyCar(String peopleId,String familyId){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		pset.setParameter("TYPE", "1");
		int num=samEsureyCarDao.query(pset).getCount();
		if(num!=0){
		float values=0;
		for(int i=0;i<num;i++){
			SamEsureyCar bean=(SamEsureyCar)samEsureyCarDao.query(pset).getRecord(i).toBean(SamEsureyCar.class);
			values=values+Float.parseFloat(bean.getRegValue());
		}		
		List<SamEsureyPeopleEstate> soList=new ArrayList<SamEsureyPeopleEstate>();
		SamEsureyPeopleEstate estateBean=new SamEsureyPeopleEstate();		
		String id=IdHelp.getUUID30();
		estateBean.setId(id);
		estateBean.setPeopleId(peopleId);
		estateBean.setFamilyId(familyId);
		estateBean.setType("1");
		estateBean.setItem("7");
		estateBean.setNum(Float.toString(values));
		soList.add(estateBean);
		samEsureyPeopleEstateDao.save(soList);
		}
	}

	/**
	 * 银行财产信息
	 * @param peopleId
	 */
	public  void getBankEstate(String peopleId,String familyId){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		pset.setParameter("TYPE", "1");
		int isFlag=samEsureyBankDao.query(pset).getCount();
		if(isFlag!=0){
		SamEsureyBank bean=(SamEsureyBank)samEsureyBankDao.query(pset).getRecord(0).toBean(SamEsureyBank.class);
		List<SamEsureyPeopleEstate> soList=new ArrayList<SamEsureyPeopleEstate>();
		SamEsureyPeopleEstate estateBean=new SamEsureyPeopleEstate();		
		String id=IdHelp.getUUID30();
		estateBean.setId(id);
		estateBean.setPeopleId(peopleId);
		estateBean.setFamilyId(familyId);
		estateBean.setType("1");
		estateBean.setItem("4");
		estateBean.setNum(Float.toString((Float.parseFloat(bean.getTotalSavings())+Float.parseFloat(bean.getTotalBond()))));
		soList.add(estateBean);
		samEsureyPeopleEstateDao.save(soList);
		}
	}
	/**
	 * 有价证券信息
	 * @param peopleId
	 */
	public void getSecuritiesEstate(String peopleId,String familyId){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		pset.setParameter("TYPE", "1");
		int isFlag=samEsureySecuritiesDao.query(pset).getCount();
		if(isFlag!=0){
		SamEsureySecurities bean=(SamEsureySecurities)samEsureySecuritiesDao.query(pset).getRecord(0).toBean(SamEsureySecurities.class);
		List<SamEsureyPeopleEstate> soList=new ArrayList<SamEsureyPeopleEstate>();
		SamEsureyPeopleEstate estateBean=new SamEsureyPeopleEstate();		
		String id=IdHelp.getUUID30();
		estateBean.setId(id);
		estateBean.setPeopleId(peopleId);
		estateBean.setFamilyId(familyId);
		estateBean.setType("1");
		estateBean.setItem("6");
		Float stock=Float.parseFloat(bean.getStock());
		Float fund=Float.parseFloat(bean.getFund());
		Float money=Float.parseFloat(bean.getMoney());
		estateBean.setNum(Float.toString((stock+fund+money)));
		soList.add(estateBean);
		samEsureyPeopleEstateDao.save(soList);
		}
	}
}
