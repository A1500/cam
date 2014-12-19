package com.inspur.cams.drel.sam.cmd;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.baseinfo.domain.IBaseinfoDomain;
import com.inspur.cams.comm.lob.Blob;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.sam.data.SamApplyFiles;
import com.inspur.cams.drel.sam.domain.ISamApplyFilesDomain;

/**
 * 
 * @title:申请材料cmd
 * @description:
 * @author:
 * @since:2012-05-05
 * @version:1.0
 */
public class SamApplyFilesCmd extends BaseAjaxCommand {
	ISamApplyFilesDomain samApplyFilesDomain = ScaComponentFactory.getService(ISamApplyFilesDomain.class, "samApplyFilesDomain/samApplyFilesDomain");
	public void delete() {
		String delId=(String) getParameter("delId");
		samApplyFilesDomain.delete(delId);
	}

	/**
	 * 保存上传文件到数据库
	 */
	@Trans
	public void saveUpload() {
		Record uploadRd = (Record) getParameter("uploadRd");
		SamApplyFiles samApplyFiles = (SamApplyFiles) uploadRd.toBean(SamApplyFiles.class);
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > 1 * 1024 * 1024) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			String fileName = uploadfile.getFileName();
			samApplyFiles.setFileName(fileName);
			samApplyFiles.setFileContent(uploadfile);
			
			String applyFileId = samApplyFiles.getApplyFileId();
			if (applyFileId == null || "".equals(applyFileId)) {
				samApplyFiles.setApplyFileId(IdHelp.getUUID30());
				samApplyFilesDomain.insert(samApplyFiles);
			}
			samApplyFilesDomain.updateWithFile(samApplyFiles);
		}
	}

	/**
	 * 保存扫描文件到数据库
	 * 
	 * 
	 */
	@Trans
	public void saveScan() {
		Record scanRd = (Record) getParameter("scanRd");
		String fileContext = (String) getParameter("fileMess");
		SamApplyFiles samApplyFiles = (SamApplyFiles) scanRd.toBean(SamApplyFiles.class);
		Blob blob = new Blob();
		blob.setData(fileContext);
		try {
			if (blob.getFileData().length > 5 * 1024 * 1024) {
				throw new RuntimeException(samApplyFiles.getFileName() + "  文件过大！");
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		samApplyFiles.setFileContent(blob);
		String applyFileId = samApplyFiles.getApplyFileId();
		if (applyFileId == null || "".equals(applyFileId)) {
			samApplyFiles.setApplyFileId(IdHelp.getUUID30());
			samApplyFilesDomain.insert(samApplyFiles);
		}else{
			samApplyFilesDomain.update(samApplyFiles);
		}
	}
}
