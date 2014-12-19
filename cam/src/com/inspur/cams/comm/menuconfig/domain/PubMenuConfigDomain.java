package com.inspur.cams.comm.menuconfig.domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.menuconfig.dao.IPubMenuConfigDao;
import com.inspur.cams.comm.menuconfig.data.PubMenuConfig;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;

public class PubMenuConfigDomain implements IPubMenuConfigDomain{
	
	@Reference
	private IPubMenuConfigDao pubMenuConfigDao ;
	
	/**
	 * 应用当前组织机构下所有员工的方法
	 */
	public void applyMenuAll(Record[] dsRecords,String menuTypeId,String menuTypeName){
		if (dsRecords == null || dsRecords.length == 0) {
			throw new RuntimeException("请选择相应的数据后再应用菜单！");
		}
		//需如果数据库没有配置，要插入的list
		List memuInsertList = new ArrayList();
		//需如果数据库已经配置，要修改的list
		List memuUpdateList = new ArrayList();
		for (int i = 0; i < dsRecords.length; i++) {
			//组装data
			String organCode  = (String)dsRecords[i].get("ORGAN_CODE");
			PubMenuConfig pubMenuConfig = new PubMenuConfig();
			pubMenuConfig.setOrganCode(organCode);
			pubMenuConfig.setOrganName((String)dsRecords[i].get("ORGAN_NAME"));
			pubMenuConfig.setMenuTypeId(menuTypeId);
			pubMenuConfig.setMenuTypeName(menuTypeName);
			pubMenuConfig.setDealPersonId(BspUtil.getEmpOrganId());
			pubMenuConfig.setDealPersonName(BspUtil.getEmpOrgan().getOrganName());
			pubMenuConfig.setDealTime(DateUtil.getTime());
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("ORGAN_CODE", organCode);
			List list = pubMenuConfigDao.queryNoPage(map);
			//判断数据库中是否已经配置过
			if(list.size()==0){
				memuInsertList.add(pubMenuConfig);
			}else{
				memuUpdateList.add(pubMenuConfig);
			}
		}
		//执行批量插入
		pubMenuConfigDao.batchInsert(memuInsertList);
		//执行批量修改
		pubMenuConfigDao.batchUpdate(memuUpdateList);
	}

}
