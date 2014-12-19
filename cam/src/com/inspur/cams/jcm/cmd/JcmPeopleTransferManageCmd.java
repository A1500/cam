package com.inspur.cams.jcm.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.JcmPeopleTransferManage;
import com.inspur.cams.jcm.domain.IJcmPeopleTransferManageDomain;

/**
 * 人员调动表cmd
 * @author 
 * @date 2014-12-15
 */
public class JcmPeopleTransferManageCmd extends BaseAjaxCommand {

	private IJcmPeopleTransferManageDomain jcmPeopleTransferManageDomain = ScaComponentFactory
			.getService(IJcmPeopleTransferManageDomain.class, "jcmPeopleTransferManageDomain/jcmPeopleTransferManageDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		JcmPeopleTransferManage JcmPeopleTransferManage = (JcmPeopleTransferManage) record.toBean(JcmPeopleTransferManage.class);
		jcmPeopleTransferManageDomain.insert(JcmPeopleTransferManage);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		JcmPeopleTransferManage JcmPeopleTransferManage = (JcmPeopleTransferManage) record.toBean(JcmPeopleTransferManage.class);
		jcmPeopleTransferManageDomain.update(JcmPeopleTransferManage);
	}
	
	// 删除
	public void delete() {
		String id = (String) getParameter("id");
		jcmPeopleTransferManageDomain.delete(id);
	}
	
	public void save(){
		List<JcmPeopleTransferManage> equList = new ArrayList<JcmPeopleTransferManage>();
		Record[] records = (Record[]) getParameter("records");
		if(records!=null){
			for(int i=0;i<records.length;i++){
				JcmPeopleTransferManage JcmPeopleTransferManage = (JcmPeopleTransferManage) records[i].toBean(JcmPeopleTransferManage.class);
				equList.add(JcmPeopleTransferManage);
			}	
		}
		jcmPeopleTransferManageDomain.save(equList);
	}
}