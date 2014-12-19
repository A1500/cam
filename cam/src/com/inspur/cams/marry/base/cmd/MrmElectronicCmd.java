package com.inspur.cams.marry.base.cmd;

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
import com.inspur.cams.marry.base.data.MrmElectronic;
import com.inspur.cams.marry.base.domain.IMrmElectronicDomain;
/**
 * 电子档案上传保存到数据库
 */
public class MrmElectronicCmd extends BaseAjaxCommand{
	// 获取SCA组件
	private IMrmElectronicDomain service = ScaComponentFactory.getService(IMrmElectronicDomain.class,"mrmElectronicDomain/mrmElectronicDomain");
	/**
	 * 保存上传文件到数据库
	 */
	public void uploadSave(){
		Record uploadRd = (Record) getParameter("uploadRd");
		String fileMess = (String) getParameter("fileMess");
		MrmElectronic electronicBean = (MrmElectronic) uploadRd.toBean(MrmElectronic.class);
		electronicBean.setFileMess(fileMess);
		electronicBean.setIfValid("1");
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		List<MrmElectronic> list = new ArrayList<MrmElectronic>();
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > 10 * 1024 * 1024) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			MrmElectronic dataBean = new MrmElectronic();
			dataBean.setElectronicId(IdHelp.getUUID30());
			dataBean.setDeptId(electronicBean.getDeptId());
			dataBean.setApplyType(electronicBean.getApplyType());
			dataBean.setIfValid(electronicBean.getIfValid());
			dataBean.setCatalogCode(electronicBean.getCatalogCode());
			dataBean.setFileName(uploadfile.getFileName());
			dataBean.setFileMess(electronicBean.getFileMess());
			dataBean.setApplyId(electronicBean.getApplyId());
			dataBean.setFiles(uploadfile);
			dataBean.setFileCode(electronicBean.getFileCode());
			list.add(dataBean);
		}
		service.uploadSave(list);
	}
	
	/**
	 * 保存文拍仪扫描上传文件到数据库
	 */
	public void uploadSaveByEquipment(){
		Record uploadRd = (Record) getParameter("uploadRd");
		String fileMess = (String) getParameter("fileMess");
		MrmElectronic electronicBean = (MrmElectronic) uploadRd.toBean(MrmElectronic.class);
		electronicBean.setFileMess(fileMess);
		electronicBean.setIfValid("1");
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		List<MrmElectronic> list = new ArrayList<MrmElectronic>();
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > 10 * 1024 * 1024) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			MrmElectronic dataBean = new MrmElectronic();
			dataBean.setElectronicId(IdHelp.getUUID30());
			dataBean.setDeptId(electronicBean.getDeptId());
			dataBean.setApplyType(electronicBean.getApplyType());
			dataBean.setIfValid(electronicBean.getIfValid());
			dataBean.setCatalogCode(electronicBean.getCatalogCode());
			dataBean.setFileName(uploadfile.getFileName());
			dataBean.setFileMess(electronicBean.getFileMess());
			dataBean.setApplyId(electronicBean.getApplyId());
			dataBean.setFiles(uploadfile);
			dataBean.setFileCode(electronicBean.getFileCode());
			list.add(dataBean);
		}
		service.uploadSave(list);
	}
	/**
	 * 通过主键删除档案文件
	 */
	public void delElectronic(){
		String electronicId = (String)getParameter("electronicId");
		service.delete(electronicId);
	}
	/**
	 * 变更中单个保存文件
	 */
	public void saveFile() {
		Record record = (Record) getParameter("record");
		MrmElectronic electronicBean = (MrmElectronic) record.toBean(MrmElectronic.class);
		electronicBean.setIfValid("1");
		electronicBean.setElectronicId(IdHelp.getUUID30());
		electronicBean.setFileName(electronicBean.getFiles().getFileName());
		service.insert(electronicBean);
	}
	/**
	 * 上传印章备案
	 */
	public void uploadSignet(){
		String fileMess = (String) getParameter("fileMess");
		String deptId = (String) getParameter("deptId");
		String applyType = (String) getParameter("applyType");
		String applyId = (String) getParameter("applyId");
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		List<MrmElectronic> list = new ArrayList<MrmElectronic>();
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > 10 * 1024 * 1024) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			MrmElectronic dataBean = new MrmElectronic();
			dataBean.setElectronicId(IdHelp.getUUID30());
			dataBean.setDeptId(deptId);
			dataBean.setApplyId(applyId);
			dataBean.setApplyType(applyType);
			dataBean.setIfValid("1");
			dataBean.setFileName(uploadfile.getFileName());
			dataBean.setFileMess(fileMess);
			dataBean.setFiles(uploadfile);
			list.add(dataBean);
		}
		service.batchInsert(list);
	}
	
	public void savePieceNumber(){
		Record[] mrmElectronicRecords = (Record[])getParameter("mrmElectronicRecords");
		service.savePieceNumber(mrmElectronicRecords);
		setReturn("status", "0");
	}
}
