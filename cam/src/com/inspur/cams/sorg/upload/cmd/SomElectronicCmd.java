package com.inspur.cams.sorg.upload.cmd;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;
/**
 * 社会组织电子档案上传保存到数据库
 * @author Muqi
 * @date 2011年7月19日11:36:07
 */
public class SomElectronicCmd extends BaseAjaxCommand{
	// 获取SCA组件
	private ISomElectronicDomain service = ScaComponentFactory.getService(ISomElectronicDomain.class,"somElectronicDomain/somElectronicDomain");
	private static int maxFileSize = 20 * 1024 * 1024;
	/**
	 * 保存上传文件到数据库
	 */
	public void uploadSave(){
		Record uploadRd = (Record) getParameter("uploadRd");
		String fileMess = (String) getParameter("fileMess");
		SomElectronic electronicBean = (SomElectronic) uploadRd.toBean(SomElectronic.class);
		electronicBean.setFileMess(fileMess);
		electronicBean.setIfValid("1");
		electronicBean.setCreateTime(DateUtil.getTime());
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		List<SomElectronic> list = new ArrayList<SomElectronic>();
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > maxFileSize) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			SomElectronic dataBean = new SomElectronic();
			dataBean.setElectronicId(IdHelp.getUUID30());
			dataBean.setSorgId(electronicBean.getSorgId());
			dataBean.setSorgKind(electronicBean.getSorgKind());
			dataBean.setSorgType(electronicBean.getSorgType());
			dataBean.setCnName(electronicBean.getCnName());
			dataBean.setApplyType(electronicBean.getApplyType());
			dataBean.setIfValid(electronicBean.getIfValid());
			dataBean.setCatalogCode(electronicBean.getCatalogCode());
			dataBean.setFileName(uploadfile.getFileName());
			dataBean.setFileMess(electronicBean.getFileMess());
			dataBean.setTaskCode(electronicBean.getTaskCode());
			dataBean.setFiles(uploadfile);
			dataBean.setCreatePeople(electronicBean.getCreatePeople());
			dataBean.setCreateTime(electronicBean.getCreateTime());
			dataBean.setFileCode(electronicBean.getFileCode());
			dataBean.setDutyId(electronicBean.getDutyId());
			list.add(dataBean);
		}
		service.uploadSave(list);
	}
	/**
	 * 选择已经上传的附件
	 */
	public void saveExistFile(){
		String dutyId= (String) getParameter("dutyId");
		String electronicId= (String) getParameter("electronicId");
		service.saveExistFile(dutyId,electronicId);
	}
	/**
	 * 保存文拍仪扫描上传文件到数据库
	 */
	public void uploadSaveByEquipment(){
		Record uploadRd = (Record) getParameter("uploadRd");
		String fileMess = (String) getParameter("fileMess");
		SomElectronic electronicBean = (SomElectronic) uploadRd.toBean(SomElectronic.class);
		electronicBean.setFileMess(fileMess);
		electronicBean.setIfValid("1");
		electronicBean.setCreateTime(DateUtil.getTime());
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		List<SomElectronic> list = new ArrayList<SomElectronic>();
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > maxFileSize) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			SomElectronic dataBean = new SomElectronic();
			dataBean.setElectronicId(IdHelp.getUUID30());
			dataBean.setSorgId(electronicBean.getSorgId());
			dataBean.setSorgKind(electronicBean.getSorgKind());
			dataBean.setSorgType(electronicBean.getSorgType());
			dataBean.setCnName(electronicBean.getCnName());
			dataBean.setApplyType(electronicBean.getApplyType());
			dataBean.setIfValid(electronicBean.getIfValid());
			dataBean.setCatalogCode(electronicBean.getCatalogCode());
			dataBean.setFileName(uploadfile.getFileName());
			dataBean.setFileMess(electronicBean.getFileMess());
			dataBean.setTaskCode(electronicBean.getTaskCode());
			dataBean.setFiles(uploadfile);
			dataBean.setCreatePeople(electronicBean.getCreatePeople());
			dataBean.setCreateTime(electronicBean.getCreateTime());
			dataBean.setFileCode(electronicBean.getFileCode());
			dataBean.setDutyId(electronicBean.getDutyId());
			list.add(dataBean);
		}
		service.uploadSave(list);
	}
	/**
	 * 通过主键删除档案文件
	 */
	public void delElectronic(){
		String electronicId = (String)getParameter("electronicId");
		service.deleteById(electronicId);
	}
	/**
	 * 删除SOM_ELECTRONIC和SOM_DUTY_ELECTRONIC
	 */
	public void delElectronicAndDutyElectronic(){
		Record record = (Record) getParameter("record");
		SomElectronic electronicBean = (SomElectronic) record.toBean(SomElectronic.class);
		service.delElectronicAndDutyElectronic(electronicBean);
	}
	/**
	 * 删除法定代表人的SOM_ELECTRONIC和SOM_DUTY_ELECTRONIC
	 */
	public void delLegalElectronicAndDutyElectronic(){
		ParameterSet pset = getParameterSet();
		service.delLegalElectronicAndDutyElectronic(pset);
	}
	/**
	 * 变更中单个保存文件
	 */
	public void saveFile() {
		Record record = (Record) getParameter("record");
		SomElectronic electronicBean = (SomElectronic) record.toBean(SomElectronic.class);
		electronicBean.setIfValid("1");
		electronicBean.setCreateTime(DateUtil.getTime());
		electronicBean.setElectronicId(IdHelp.getUUID30());
		electronicBean.setFileName(electronicBean.getFiles().getFileName());
		service.insert(electronicBean);
	}
	/**
	 * 上传印章备案
	 */
	public void uploadSignet(){
		String fileMess = (String) getParameter("fileMess");
		String sorgId = (String) getParameter("sorgId");
		String applyType = (String) getParameter("applyType");
		String sorgKind = (String) getParameter("sorgKind");
		String sorgType = (String) getParameter("sorgType");
		String cnName = (String) getParameter("cnName");
		String taskCode = (String) getParameter("taskCode");
		String createTime = DateUtil.getTime();
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		List<SomElectronic> list = new ArrayList<SomElectronic>();
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > maxFileSize) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			SomElectronic dataBean = new SomElectronic();
			dataBean.setElectronicId(IdHelp.getUUID30());
			dataBean.setSorgId(sorgId);
			dataBean.setSorgKind(sorgKind);
			dataBean.setSorgType(sorgType);
			dataBean.setTaskCode(taskCode);
			dataBean.setCnName(cnName);
			dataBean.setApplyType(applyType);
			dataBean.setIfValid("1");
			dataBean.setFileName(uploadfile.getFileName());
			dataBean.setFileMess(fileMess);
			dataBean.setFiles(uploadfile);
			dataBean.setCreateTime(createTime);
			list.add(dataBean);
		}
		service.batchInsert(list);
	}
	
	public void savePieceNumber(){
		Record[] somElectronicRecords = (Record[])getParameter("somElectronicRecords");
		service.savePieceNumber(somElectronicRecords);
		setReturn("status", "0");
	}
}
