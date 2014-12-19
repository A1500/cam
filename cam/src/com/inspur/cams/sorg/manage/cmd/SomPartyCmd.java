package com.inspur.cams.sorg.manage.cmd;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.data.SomParty;
import com.inspur.cams.sorg.base.data.SomPartyChange;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.base.data.SomPartyPraise;
import com.inspur.cams.sorg.manage.domain.ISomPartyOrganDomain;
/**
 * 
 * @author Jiangzhaobao
 *
 * @date 2011-6-8
 */
public class SomPartyCmd extends BaseAjaxCommand{
	private ISomPartyOrganDomain service = ScaComponentFactory.getService(ISomPartyOrganDomain.class, "somPartyOrganDomain/somPartyOrganDomain");
	
	/**
	 * 增加党建
	 */
	public void insertParty(){
		service.insertParty(getPartyInfo());
	}
	/**
	 * 更新党建
	 */
	public void updateParty(){
		service.updateParty(getPartyInfo());
	}
	/**
	 * 注销党建
	 */
	public void cancelParty(){
		Record record=(Record)getParameter("somParty");
		SomParty dataBean =(SomParty)record.toBean(SomParty.class);	
		service.cancelParty(dataBean);
	}
	public SomParty getPartyInfo(){
		Record record=(Record)getParameter("somParty");
		Record[] somPartyPraiseRecords=(Record[])getParameter("somPartyPraiseRecords");
		Record[] somPartyChangeRecords=(Record[])getParameter("somPartyChangeRecords");
		SomParty dataBean =(SomParty)record.toBean(SomParty.class);	
		if (somPartyPraiseRecords != null) {
			List<SomPartyPraise> somPartyPraiseList = new ArrayList<SomPartyPraise>();
			for (int j = 0; j < somPartyPraiseRecords.length; j++) {
				SomPartyPraise somPartyPraise = (SomPartyPraise) somPartyPraiseRecords[j].toBean(SomPartyPraise.class);
				if (somPartyPraise.getMemberId().equals(dataBean.getPartyId())) {
					somPartyPraiseList.add(somPartyPraise);							
				}
			}
			dataBean.setSomPartyPraiseList(somPartyPraiseList);
		}
		if (somPartyChangeRecords != null) {
			List<SomPartyChange> somPartyChangeList = new ArrayList<SomPartyChange>();
			for (int j = 0; j < somPartyChangeRecords.length; j++) {
				SomPartyChange somPartyChange = (SomPartyChange) somPartyChangeRecords[j].toBean(SomPartyChange.class);
				if (somPartyChange.getPartyId().equals(dataBean.getPartyId())) {
					somPartyChangeList.add(somPartyChange);							
				}
			}
			dataBean.setSomPartyChangeList(somPartyChangeList);
		}
		return dataBean;
	}
	/**
	 * 保存上传文件到数据库
	 */
	public void uploadSave_praise(){
		Record uploadRd = (Record) getParameter("uploadRd");
		SomPartyPraise somPartyPraise = (SomPartyPraise) uploadRd.toBean(SomPartyPraise.class);
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		//List<SomElectronic> list = new ArrayList<SomElectronic>();
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > 5 * 1024 * 1024) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			String fileName =uploadfile.getFileName();
			somPartyPraise.setFileName(fileName);
			somPartyPraise.setFiles(uploadfile);		
			String praiseId=service.uploadSave_praise(somPartyPraise);
			setReturn("praiseId", praiseId);
			setReturn("fileName", fileName);
		}
	}
	/**
	 * 保存上传文件到数据库
	 */
	public void uploadSave_change(){
		Record uploadRd = (Record) getParameter("uploadRd");
		SomPartyChange somPartyChange = (SomPartyChange) uploadRd.toBean(SomPartyChange.class);
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		//List<SomElectronic> list = new ArrayList<SomElectronic>();
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > 5 * 1024 * 1024) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			String auditFile =uploadfile.getFileName();
			somPartyChange.setAuditFile(auditFile);
			somPartyChange.setFiles(uploadfile);
			String changeId=service.uploadSave_change(somPartyChange);
			setReturn("changeId", changeId);
			setReturn("auditFile", auditFile);
		}
	}
	
	public void saveFullPartyOut(){
		Record record=(Record)getParameter("somParty");
		String outTime=(String)getParameter("outTime");
		String outToOrgan=(String)getParameter("outToOrgan");
		SomParty somParty =(SomParty)record.toBean(SomParty.class);
		somParty.setOutTime(outTime);
		somParty.setOutType("1");
		somParty.setOutToOrgan(outToOrgan);
		somParty.setPartyStatus("2");
		service.saveFullPartyOut(somParty);
	}
}


