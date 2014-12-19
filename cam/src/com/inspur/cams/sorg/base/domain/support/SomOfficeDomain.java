package com.inspur.cams.sorg.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomOfficeDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomOffice;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomOfficeDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomIdHelp;

/**
 * 社会组织内设机构domain接口
 * @author shgtch
 * @date 2011-5-11
 */
public class SomOfficeDomain implements ISomOfficeDomain {
	
	@Reference
	private ISomOfficeDao somOfficeDao;
	
	@Reference
	private ISomApplyDomain somApplyDomain;
	
	/**
	 * 查询内设机构信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somOfficeDao.query(pset);
	}

	/**
	 * 增加内设机构信息
	 * @param dataBean
	 */	
	public void insert(SomOffice somOffice) {
		somOffice.setId(IdHelp.getUUID30());
		somOffice.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		somOffice.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somOffice.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		somOffice.setCreateTime(DateUtil.getTime());
		somOfficeDao.insert(somOffice);
		
	}
	
	/**
	 * 备案中增加内设机构信息，增加一条apply信息
	 * @param dataBean
	 */	
	public void insertOfficeAndApply(SomOffice somOffice) {
		somOffice.setId(IdHelp.getUUID30());
		somOffice.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		somOffice.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somOffice.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		somOffice.setCreateTime(DateUtil.getTime());
		somOfficeDao.insert(somOffice);
		
		SomApply somApply = new SomApply();
		somApply.setSorgId(somOffice.getSorgId());
		somApply.setTaskCode(somOffice.getTaskCode());
		if(somOffice.getSorgType().equals("S")){
			somApply.setApplyType(ApplyType.SOM_GROUP_OFFICE);
		}
		if(somOffice.getSorgType().equals("M")){
			somApply.setApplyType(ApplyType.SOM_UNGOV_ENTITY);
		}
		if(somOffice.getSorgType().equals("J")){
			somApply.setApplyType(ApplyType.SOM_FUND_OFFICE);
		}
		somApply.setSorgType(somOffice.getSorgType());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAuditTime(DateUtil.getTime());
		somApplyDomain.insert(somApply);
	}
	
	/**
	 * 增加内设机构信息
	 * @param dataBean
	 */	
	public void insertOnline(SomOffice somOffice) {
		somOffice.setId(IdHelp.getUUID30());
		somOffice.setCreateTime(DateUtil.getTime());
		somOfficeDao.insert(somOffice);
	}
	
	/**
	 * 修改内设机构信息
	 * @param lists
	 */
	public void update(SomOffice somOffice) {
		somOfficeDao.update(somOffice);
	}
	
	/**
	 * 批量增加社会组织内设机构信息
	 * @param somOffice
	 */
	public void batchInsert(List<SomOffice> list) {
		somOfficeDao.batchInsert(list);
	}
	/**
	 * 批量删除社会组织内设机构信息
	 * @param somOffice
	 */
	public void batchDelete(String[] ids) {
		somOfficeDao.batchDelete(ids);
	}

	/**
	 * 删除社会组织内设机构信息
	 * @param somOffice
	 */
	public void delete(SomOffice dataBean) {
		somOfficeDao.delete(dataBean.getId());
	}
	
	public void delByTaskCode(String taskCode) {
		somOfficeDao.delByTaskCode(taskCode);
	}
	
}
