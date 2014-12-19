package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcPopulateInfoDao;
import com.inspur.cams.cdc.base.data.CdcPopulateInfo;
import com.inspur.cams.cdc.base.domain.ICdcPopulateInfoDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基础信息人口状况信息domain实现类
 * @author shgtch
 * @date 2011-12-30
 */
public class CdcPopulateInfoDomain implements ICdcPopulateInfoDomain {

	@Reference
	private ICdcPopulateInfoDao cdcPopulateInfoDao;

	/**
	 * 查询基础信息人口状况信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcPopulateInfoDao.query(pset);
	}

	/**
	 * 增加基础信息人口状况信息
	 * @param cdcPopulateInfo
	 */
	public void insert(CdcPopulateInfo cdcPopulateInfo) {
		cdcPopulateInfo.setRecordId(cdcPopulateInfo.getOrganCode() + IdHelp.getUUID32());
		cdcPopulateInfo.setStatus("0");
		cdcPopulateInfo.setCreateTime(DateUtil.getTime());
		cdcPopulateInfoDao.insert(cdcPopulateInfo);
	}
	
	/**
	 * 修改基础信息人口状况信息
	 * @param cdcPopulateInfo
	 */
	public void update(CdcPopulateInfo cdcPopulateInfo) {
		cdcPopulateInfoDao.update(cdcPopulateInfo);
	}
	
	/**
	 * 删除基础信息人口状况信息
	 * @param populateId
	 */
	public void delete(String populateId) {
		cdcPopulateInfoDao.delete(populateId);
	}
	
	/**
	 * 对本单位数据进行汇总
	 * @param cdcPopulateInfo
	 */
	public void sum(CdcPopulateInfo cdcPopulateInfo) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcPopulateInfo.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_TYPE@=", cdcPopulateInfo.getReportType());
		ps.setParameter("REPORT_DATE@=", cdcPopulateInfo.getReportDate());
		DataSet childDataSet = cdcPopulateInfoDao.query(ps);
		
		// 数据合计并保存
		cdcPopulateInfo.setCommunityNum(childDataSet.sum("communityNum"));
		cdcPopulateInfo.setPopulateNum(childDataSet.sum("populateNum"));
		cdcPopulateInfo.setPeopleNum(childDataSet.sum("peopleNum"));
		cdcPopulateInfo.setFemaleNum(childDataSet.sum("femaleNum"));
		cdcPopulateInfo.setResidePopulateNum(childDataSet.sum("residePopulateNum"));
		cdcPopulateInfo.setResidePeopleNum(childDataSet.sum("residePeopleNum"));
		cdcPopulateInfo.setResideFemaleNum(childDataSet.sum("resideFemaleNum"));
		cdcPopulateInfo.setRegisteNum(childDataSet.sum("registeNum"));
		cdcPopulateInfo.setFloatingNum(childDataSet.sum("floatingNum"));
		cdcPopulateInfo.setOutsideNum(childDataSet.sum("outsideNum"));
		cdcPopulateInfo.setFarmingNum(childDataSet.sum("farmingNum"));
		cdcPopulateInfo.setNonFarmingNum(childDataSet.sum("nonFarmingNum"));
		cdcPopulateInfo.setPipiNum(childDataSet.sum("pipiNum"));
		cdcPopulateInfo.setPipiFourteenNum(childDataSet.sum("pipiFourteenNum"));
		cdcPopulateInfo.setPipiEgihteenNum(childDataSet.sum("pipiEgihteenNum"));
		cdcPopulateInfo.setPipiSixtyNum(childDataSet.sum("pipiSixtyNum"));
		cdcPopulateInfo.setPipiSeventyNum(childDataSet.sum("pipiSeventyNum"));
		cdcPopulateInfo.setPipiEightyNum(childDataSet.sum("pipiEightyNum"));
		cdcPopulateInfo.setPipiNinetyNum(childDataSet.sum("pipiNinetyNum"));
		cdcPopulateInfo.setPipiFemaleNum(childDataSet.sum("pipiFemaleNum"));
		cdcPopulateInfo.setPipoNum(childDataSet.sum("pipoNum"));
		cdcPopulateInfo.setPipoFourteenNum(childDataSet.sum("pipoFourteenNum"));
		cdcPopulateInfo.setPipoEgihteenNum(childDataSet.sum("pipoEgihteenNum"));
		cdcPopulateInfo.setPipoSixtyNum(childDataSet.sum("pipoSixtyNum"));
		cdcPopulateInfo.setPipoSeventyNum(childDataSet.sum("pipoSeventyNum"));
		cdcPopulateInfo.setPipoEightyNum(childDataSet.sum("pipoEightyNum"));
		cdcPopulateInfo.setPipoNinetyNum(childDataSet.sum("pipoNinetyNum"));
		cdcPopulateInfo.setPipoFemaleNum(childDataSet.sum("pipoFemaleNum"));
		cdcPopulateInfo.setPopiNum(childDataSet.sum("popiNum"));
		cdcPopulateInfo.setPopiFourteenNum(childDataSet.sum("popiFourteenNum"));
		cdcPopulateInfo.setPopiEgihteenNum(childDataSet.sum("popiEgihteenNum"));
		cdcPopulateInfo.setPopiSixtyNum(childDataSet.sum("popiSixtyNum"));
		cdcPopulateInfo.setPopiSeventyNum(childDataSet.sum("popiSeventyNum"));
		cdcPopulateInfo.setPopiEightyNum(childDataSet.sum("popiEightyNum"));
		cdcPopulateInfo.setPopiNinetyNum(childDataSet.sum("popiNinetyNum"));
		cdcPopulateInfo.setPopiFemaleNum(childDataSet.sum("popiFemaleNum"));
		cdcPopulateInfo.setPartyNum(childDataSet.sum("partyNum"));
		cdcPopulateInfo.setLowestSafeguardNum(childDataSet.sum("lowestSafeguardNum"));
		cdcPopulateInfo.setFiveSafeguardNum(childDataSet.sum("fiveSafeguardNum"));
		cdcPopulateInfo.setHandicappedNum(childDataSet.sum("handicappedNum"));
		cdcPopulateInfo.setThreeNoNum(childDataSet.sum("threeNoNum"));
		cdcPopulateInfo.setPreferentialNum(childDataSet.sum("preferentialNum"));
		cdcPopulateInfo.setLoseWorkNum(childDataSet.sum("loseWorkNum"));
		cdcPopulateInfo.setAgedInsuranceNum(childDataSet.sum("agedInsuranceNum"));
		cdcPopulateInfo.setRetireNum(childDataSet.sum("retireNum"));
		cdcPopulateInfo.setBackStudentNum(childDataSet.sum("backStudentNum"));
		cdcPopulateInfo.setNojobStudentNum(childDataSet.sum("nojobStudentNum"));
		cdcPopulateInfo.setForeignerNum(childDataSet.sum("foreignerNum"));
		cdcPopulateInfo.setBackNum(childDataSet.sum("backNum"));
		cdcPopulateInfo.setCorrectNum(childDataSet.sum("correctNum"));
		cdcPopulateInfo.setDrugNum(childDataSet.sum("drugNum"));
		cdcPopulateInfo.setHeresyNum(childDataSet.sum("heresyNum"));
		
		insert(cdcPopulateInfo);
	}
	
}