package com.inspur.cams.bpt.bptinstitution.cmd;

import java.util.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptMartyrBuildingsLegalDao;
import com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildings;
import com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildingsLegal;
import com.inspur.cams.bpt.bptinstitution.domain.IBptMartyrBuildingsDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptMartyrBuildingsSaveCommand
 * @description:
 * @author:
 * @since:2011-06-15
 * @version:1.0
*/
public class BptMartyrBuildingsCommand extends BaseAjaxCommand {
		private String mbuildingId = IdHelp.getUUID30();
	public void save() {
		IBptMartyrBuildingsDomain service = ScaComponentFactory.getService(IBptMartyrBuildingsDomain.class,
				"BptMartyrBuildingsDomain/BptMartyrBuildingsDomain");
		BptMartyrBuildings bptmartyrbuildings = getBptMartyrBuildings();
		if (bptmartyrbuildings.isNew()) {//当新添加一条信息时，写入新的id值
			bptmartyrbuildings.setMbuildingId(mbuildingId);
		}
		List BptMartyrBuildingsLegalList = getBptMartyrBuildingsLegalList();
		service.saveBptMartyrBuildingsLegalList(bptmartyrbuildings, BptMartyrBuildingsLegalList);
		
	}
	@Trans
	public void delete() {
		IBptMartyrBuildingsDomain service = ScaComponentFactory.getService(IBptMartyrBuildingsDomain.class,
				"BptMartyrBuildingsDomain/BptMartyrBuildingsDomain");
		String[] delId = (String[]) getParameter("delIds");
		List list = new ArrayList();
		for(int i=0;i<delId.length;i++){
			list.add(delId[i]);
		}
		
		BptMartyrBuildingsLegalDao bptmartyrbuildingslegalDao = null;
		try{
			bptmartyrbuildingslegalDao = new BptMartyrBuildingsLegalDao();
		}catch(Exception e){
			
		}
		bptmartyrbuildingslegalDao.batchDeleteByBptMartyrBuildings(delId);
		
		service.delete(list);
	}

	private BptMartyrBuildings getBptMartyrBuildings() {
		Record bptmartyrbuildingsRecord = (Record) getParameter("BptMartyrBuildingsRecord");
		BptMartyrBuildings bean=(BptMartyrBuildings) bptmartyrbuildingsRecord.toBean(BptMartyrBuildings.class);
		bean.setRegOrganCode(BspUtil.getOrganCode());
		return bean;
	}
	
	private List<BptMartyrBuildingsLegal> getBptMartyrBuildingsLegalList() {
		Record[] bptmartyrbuildingslegalRecords = (Record[]) getParameter("BptMartyrBuildingsLegalRecords");
		if (bptmartyrbuildingslegalRecords == null || bptmartyrbuildingslegalRecords.length == 0) {
			return null;
		}
		List<BptMartyrBuildingsLegal> list = new ArrayList<BptMartyrBuildingsLegal>();
		for (int i = 0; i < bptmartyrbuildingslegalRecords.length; i++) {
			BptMartyrBuildingsLegal bptmartyrbuildingslegal = (BptMartyrBuildingsLegal) bptmartyrbuildingslegalRecords[i].toBean(BptMartyrBuildingsLegal.class);
			if (bptmartyrbuildingslegal.isNew()) {//当新加入一条法人代表信息时，写入法人代表的id值，及MbuildingId的值
				bptmartyrbuildingslegal.setLegalId(IdHelp.getUUID30());
				bptmartyrbuildingslegal.setMbuildingId(mbuildingId);
			}
			list.add(bptmartyrbuildingslegal);
		}

		return list;
	}
	
}