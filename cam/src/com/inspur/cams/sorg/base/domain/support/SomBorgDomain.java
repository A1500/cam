package com.inspur.cams.sorg.base.domain.support;

import org.loushang.bsp.id.util.MaxValueUtil;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomBorgDao;
import com.inspur.cams.sorg.base.data.SomBorg;
import com.inspur.cams.sorg.base.data.SomBorgChange;
import com.inspur.cams.sorg.base.domain.ISomBorgChangeDomain;
import com.inspur.cams.sorg.base.domain.ISomBorgDomain;

/**
 * 业务主管单位domain实现类
 * @author yanliangliang
 * @date 2011-6-8
 */
public class SomBorgDomain implements ISomBorgDomain {
	
	@Reference
	private ISomBorgDao somBorgDao;
	
	@Reference
	private ISomBorgChangeDomain somBorgChangeDomain;

	/**
	 * 业务主管单位添加
	 * @param somCert
	 * @return
	 */
	public String insert(SomBorg somBorg) {
		String code = MaxValueUtil.nextStringValue("BORG_CODE");
		somBorg.setBorgCode(code);
		somBorg.setCreateTime(DateUtil.getTime());
		somBorg.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		somBorg.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somBorg.setMorgCode(BspUtil.getCorpOrgan().getOrganCode().substring(0,6));
		SomBorg s = somBorgDao.insert(somBorg);
		return s.getBorgCode();
	}

	/**
	 * 业务主管单位查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somBorgDao.query(pset);
	}

	/**
	 * 业务主管单位修改
	 * @param somBorg
	 */
	public void update(SomBorg somBorg) {
		somBorg.setModTime(DateUtil.getTime());
		somBorg.setModPeople(BspUtil.getEmpOrgan().getOrganName());
		somBorgDao.update(somBorg);
	}
	
	public void batchDelete(String[] delIds) {
		somBorgDao.batchDelete(delIds);
	}
	

	/**
	 * 业务主管单位变更
	 * @param somBorg
	 */
	public void changeBorg(SomBorg somBorg){
		SomBorgChange somBorgChange=somBorg.getSomBorgChange();
		//修改原业务主管单位
		somBorg.setIfHis("1");
		update(somBorg);
		//插入业务主管单位变更表
		somBorgChange.setChangeId(IdHelp.getUUID32());
		somBorgChange.setChangeTime(DateUtil.getTime());
		somBorgChange.setChangePerson(BspUtil.getEmpOrgan().getOrganName());
		somBorgChange.setChangeOrgan(BspUtil.getCorpOrgan().getOrganName());
		somBorgChange.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somBorgChange.setMorgArea(BspUtil.getCorpOrgan().getOrganCode().substring(0,6));
		somBorgChangeDomain.insert(somBorgChange);
	}
}
