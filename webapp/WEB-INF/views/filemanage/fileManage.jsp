<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>파일관리</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %>
    <style>
html, body { height: 100%; margin: 0; }
body { display: flex; flex-direction: column; overflow: hidden; background: #F4F6F8; }

.fm-wrap {
    flex: 1;
    min-height: 0;
    display: flex;
    gap: 12px;
    padding: 12px;
    box-sizing: border-box;
}

/* ===== 좌측: 폴더 트리 ===== */
.fm-tree-panel {
    width: 300px;
    flex-shrink: 0;
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    display: flex;
    flex-direction: column;
    min-height: 0;
}
.fm-tree-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 12px 14px;
    border-bottom: 1px solid #EDF2F7;
    flex-shrink: 0;
}
.fm-tree-header h3 {
    margin: 0;
    font-size: 15px;
    color: #2D3748;
}
.fm-new-root-btn {
    border: 1px solid #007bff;
    background: #fff;
    color: #007bff;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 600;
    padding: 5px 10px;
    cursor: pointer;
    transition: all .15s;
}
.fm-new-root-btn:hover { background: #007bff; color: #fff; }

.fm-tree-body {
    flex: 1;
    min-height: 0;
    overflow-y: auto;
    padding: 8px 6px;
}

.fm-node { user-select: none; }
.fm-node-row {
    display: flex;
    align-items: center;
    gap: 4px;
    padding: 5px 6px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13.5px;
    color: #2D3748;
    white-space: nowrap;
    position: relative;
}
.fm-node-row:hover { background: #F0F6FF; }
.fm-node-row.selected { background: #E3F0FF; color: #0056b3; font-weight: 600; }

.fm-toggle {
    width: 16px;
    height: 16px;
    flex-shrink: 0;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    font-size: 10px;
    color: #A0AEC0;
    cursor: pointer;
    transition: transform .15s;
}
.fm-toggle.expanded { transform: rotate(90deg); }
.fm-toggle.leaf { visibility: hidden; }

.fm-folder-icon { flex-shrink: 0; font-size: 14px; }
.fm-node-name { overflow: hidden; text-overflow: ellipsis; }
.fm-node-count { color: #A0AEC0; font-size: 11px; margin-left: 2px; }

.fm-node-actions {
    margin-left: auto;
    display: none;
    gap: 2px;
    flex-shrink: 0;
}
.fm-node-row:hover .fm-node-actions { display: flex; }
.fm-node-actions button {
    border: none;
    background: none;
    cursor: pointer;
    color: #A0AEC0;
    font-size: 12px;
    padding: 2px 4px;
    border-radius: 4px;
}
.fm-node-actions button:hover { background: #E2E8F0; color: #2D3748; }

.fm-children { margin-left: 18px; }

.fm-tree-empty {
    text-align: center;
    color: #A0AEC0;
    font-size: 13px;
    padding: 30px 10px;
}

/* ===== 우측: 파일 목록 ===== */
.fm-content-panel {
    flex: 1;
    min-width: 0;
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    display: flex;
    flex-direction: column;
    min-height: 0;
}
.fm-content-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 14px 18px;
    border-bottom: 1px solid #EDF2F7;
    flex-shrink: 0;
}
.fm-breadcrumb {
    font-size: 16px;
    font-weight: 700;
    color: #2D3748;
    display: flex;
    align-items: center;
    gap: 6px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.fm-breadcrumb .fm-crumb-sep { color: #CBD5E0; font-weight: 400; }
.fm-breadcrumb .fm-crumb-link { cursor: pointer; }
.fm-breadcrumb .fm-crumb-link:hover { color: #007bff; }

.fm-toolbar { display: flex; gap: 8px; flex-shrink: 0; }
.fm-toolbar button {
    height: 34px;
    padding: 0 14px;
    border-radius: 8px;
    border: 1px solid #E2E8F0;
    background: #F0F4F8;
    font-size: 13px;
    font-weight: 600;
    color: #2D3748;
    cursor: pointer;
    transition: all .13s;
}
.fm-toolbar button:hover { background: #EBF8FF; border-color: #BEE3F8; }
.fm-toolbar button.primary { background: #007bff; border-color: #007bff; color: #fff; }
.fm-toolbar button.primary:hover { background: #0056b3; border-color: #0056b3; }
.fm-toolbar button.danger { color: #e74c3c; border-color: #f5c6c0; }
.fm-toolbar button.danger:hover { background: #e74c3c; color: #fff; }
.fm-toolbar button:disabled { opacity: .45; cursor: not-allowed; }

.fm-file-list {
    flex: 1;
    min-height: 0;
    overflow-y: auto;
    padding: 8px 10px;
}
.fm-file-row {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 10px 10px;
    border-radius: 8px;
    border-bottom: 1px solid #F0F4F8;
}
.fm-file-row:hover { background: #F8FAFC; }
.fm-file-icon { font-size: 22px; flex-shrink: 0; width: 28px; text-align: center; }
.fm-file-info { flex: 1; min-width: 0; }
.fm-file-name { font-size: 14px; color: #2D3748; font-weight: 600; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.fm-file-meta { font-size: 11.5px; color: #A0AEC0; margin-top: 2px; }
.fm-file-actions { display: flex; gap: 4px; flex-shrink: 0; }
.fm-file-actions button {
    border: 1px solid #E2E8F0;
    background: #fff;
    border-radius: 6px;
    font-size: 12px;
    padding: 5px 10px;
    cursor: pointer;
    color: #4A5568;
}
.fm-file-actions button:hover { background: #F0F4F8; }
.fm-file-actions button.danger { color: #e74c3c; border-color: #f5c6c0; }
.fm-file-actions button.danger:hover { background: #e74c3c; color: #fff; }

.fm-empty-state {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    color: #CBD5E0;
    gap: 8px;
}
.fm-empty-state .fm-empty-icon { font-size: 48px; }
.fm-empty-state p { margin: 0; font-size: 14px; color: #A0AEC0; }

.fm-dropzone-active {
    outline: 2px dashed #007bff;
    outline-offset: -8px;
    background: #F0F8FF;
}

/* ===== 모달(폴더명 입력) ===== */
.fm-modal-overlay {
    display: none;
    position: fixed; top:0; left:0; right:0; bottom:0;
    background: rgba(0,0,0,0.4);
    z-index: 9999;
    align-items: center;
    justify-content: center;
}
.fm-modal-overlay.active { display: flex; }
.fm-modal {
    background: #fff;
    width: 340px;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.2);
    padding: 18px 20px;
}
.fm-modal h4 { margin: 0 0 12px 0; font-size: 15px; color: #2D3748; }
.fm-modal input[type="text"] {
    width: 100%;
    height: 36px;
    border: 1px solid #ccc;
    border-radius: 6px;
    padding: 0 10px;
    font-size: 14px;
    box-sizing: border-box;
    outline: none;
}
.fm-modal input[type="text"]:focus { border-color: #007bff; }
.fm-modal-buttons { display: flex; justify-content: flex-end; gap: 8px; margin-top: 14px; }
.fm-modal-buttons button {
    height: 34px; padding: 0 14px; border-radius: 6px;
    font-size: 13px; font-weight: 600; cursor: pointer; border: 1px solid transparent;
}
.fm-btn-ok { background: #007bff; border-color: #007bff; color: #fff; }
.fm-btn-ok:hover { background: #0056b3; }
.fm-btn-cancel { background: #F0F4F8; border-color: #E2E8F0; color: #4A5568; }
.fm-btn-cancel:hover { background: #E2E8F0; }

#fmFileInput { display: none; }
    </style>
</head>
<body>

<div class="fm-wrap">
    <!-- 좌측 폴더 트리 -->
    <div class="fm-tree-panel">
        <div class="fm-tree-header">
            <h3>📁 전체 폴더</h3>
            <button class="fm-new-root-btn" onclick="openFolderModal(null)">+ 새 폴더</button>
        </div>
        <div class="fm-tree-body" id="fmTreeBody"></div>
    </div>

    <!-- 우측 파일 목록 -->
    <div class="fm-content-panel">
        <div class="fm-content-header">
            <div class="fm-breadcrumb" id="fmBreadcrumb">폴더를 선택하세요</div>
            <div class="fm-toolbar">
                <button class="primary" id="fmBtnUpload" onclick="$('#fmFileInput').click();" disabled>⬆ 파일 업로드</button>
                <button id="fmBtnNewSub" onclick="openFolderModalForSelected();" disabled>+ 하위폴더</button>
                <button id="fmBtnRename" onclick="renameSelectedFolder();" disabled>이름변경</button>
                <button class="danger" id="fmBtnDelete" onclick="deleteSelectedFolder();" disabled>폴더삭제</button>
            </div>
            <input type="file" id="fmFileInput" multiple>
        </div>

        <div class="fm-file-list" id="fmFileList">
            <div class="fm-empty-state">
                <div class="fm-empty-icon">🗂️</div>
                <p>왼쪽에서 폴더를 선택하면 파일이 표시됩니다</p>
            </div>
        </div>
    </div>
</div>

<!-- 폴더 생성/이름변경 모달 -->
<div class="fm-modal-overlay" id="fmModalOverlay">
    <div class="fm-modal">
        <h4 id="fmModalTitle">새 폴더</h4>
        <input type="text" id="fmModalInput" placeholder="폴더 이름" maxlength="100">
        <div class="fm-modal-buttons">
            <button class="fm-btn-cancel" onclick="closeFolderModal()">취소</button>
            <button class="fm-btn-ok" onclick="submitFolderModal()">확인</button>
        </div>
    </div>
</div>

<script>
let now_page_code = "j01";
let fmFolders = [];              // 플랫 폴더 목록(서버 응답 그대로)
let fmExpanded = {};             // { folder_code: true }
let fmSelectedFolder = null;     // 현재 선택된 folder_code
let fmModalMode = "create";      // "create" | "rename"
let fmModalTargetParent = null;  // create 모드일 때 부모 folder_code(null=최상위)
let fmModalTargetFolder = null;  // rename 모드일 때 대상 folder_code
const fmCurrentUser = "${loginUser.user_name}";

$(function(){
    if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    loadFolderTree();

    $("#fmFileInput").on("change", function(){
        if(this.files && this.files.length > 0){
            uploadFiles(this.files);
            this.value = "";
        }
    });

    $("#fmModalInput").on("keydown", function(e){
        if(e.key === "Enter"){ e.preventDefault(); submitFolderModal(); }
    });
});

/* ========================= 폴더 트리 ========================= */

function loadFolderTree(){
    $.ajax({
        type: "POST",
        url: "/tkheat/filemanage/getFolderList",
        success: function(result){
            fmFolders = result || [];
            renderFolderTree();
        },
        error: function(){
            alert("폴더 목록을 불러오는 중 오류가 발생했습니다.");
        }
    });
}

function renderFolderTree(){
    const $body = $("#fmTreeBody");
    $body.empty();

    const roots = fmFolders.filter(function(f){ return f.parent_code == null; });

    if(roots.length === 0){
        $body.append('<div class="fm-tree-empty">폴더가 없습니다.<br>우측 상단의 "+ 새 폴더"로 시작해보세요.</div>');
        return;
    }

    roots.forEach(function(f){
        $body.append(renderTreeNode(f, 0));
    });
}

function renderTreeNode(folder, depth){
    const children = fmFolders.filter(function(f){ return f.parent_code === folder.folder_code; });
    const hasChildren = children.length > 0;
    const isExpanded = !!fmExpanded[folder.folder_code];
    const isSelected = fmSelectedFolder === folder.folder_code;

    let html = '<div class="fm-node" data-folder-code="' + folder.folder_code + '">';
    html += '<div class="fm-node-row' + (isSelected ? ' selected' : '') + '" onclick="selectFolder(' + folder.folder_code + ")\">";
    html += '<span class="fm-toggle' + (hasChildren ? (isExpanded ? ' expanded' : '') : ' leaf') + '" onclick="event.stopPropagation(); toggleFolder(' + folder.folder_code + ');">▶</span>';
    html += '<span class="fm-folder-icon">' + (isExpanded && hasChildren ? "📂" : "📁") + '</span>';
    html += '<span class="fm-node-name" title="' + escapeHtml(folder.folder_name) + '">' + escapeHtml(folder.folder_name) + '</span>';
    if(folder.file_count > 0){
        html += '<span class="fm-node-count">(' + folder.file_count + ')</span>';
    }
    html += '<span class="fm-node-actions">';
    html += '<button title="하위폴더 추가" onclick="event.stopPropagation(); openFolderModal(' + folder.folder_code + ');">＋</button>';
    html += '<button title="이름변경" onclick="event.stopPropagation(); openRenameModal(' + folder.folder_code + ',\'' + escapeJs(folder.folder_name) + '\');">✎</button>';
    html += '<button title="삭제" onclick="event.stopPropagation(); deleteFolder(' + folder.folder_code + ',\'' + escapeJs(folder.folder_name) + '\');">🗑</button>';
    html += '</span>';
    html += '</div>';

    if(hasChildren && isExpanded){
        html += '<div class="fm-children">';
        children.forEach(function(c){
            html += renderTreeNode(c, depth + 1);
        });
        html += '</div>';
    }

    html += '</div>';
    return html;
}

function toggleFolder(folder_code){
    fmExpanded[folder_code] = !fmExpanded[folder_code];
    renderFolderTree();
}

function selectFolder(folder_code){
    fmSelectedFolder = folder_code;
    //선택한 폴더까지 조상 폴더들을 자동으로 펼침
    let cur = fmFolders.find(function(f){ return f.folder_code === folder_code; });
    while(cur && cur.parent_code != null){
        fmExpanded[cur.parent_code] = true;
        cur = fmFolders.find(function(f){ return f.folder_code === cur.parent_code; });
    }

    renderFolderTree();
    updateBreadcrumb(folder_code);
    loadFileList(folder_code);

    $("#fmBtnUpload, #fmBtnNewSub, #fmBtnRename, #fmBtnDelete").prop("disabled", false);
}

function getFolderPath(folder_code){
    const path = [];
    let cur = fmFolders.find(function(f){ return f.folder_code === folder_code; });
    while(cur){
        path.unshift(cur);
        cur = cur.parent_code != null ? fmFolders.find(function(f){ return f.folder_code === cur.parent_code; }) : null;
    }
    return path;
}

function updateBreadcrumb(folder_code){
    const path = getFolderPath(folder_code);
    const $crumb = $("#fmBreadcrumb");
    $crumb.empty();
    path.forEach(function(f, idx){
        if(idx > 0){
            $crumb.append('<span class="fm-crumb-sep">/</span>');
        }
        const $link = $('<span class="fm-crumb-link"></span>').text(f.folder_name)
            .on("click", function(){ selectFolder(f.folder_code); });
        $crumb.append($link);
    });
}

/* ========================= 폴더 생성/이름변경/삭제 모달 ========================= */

function openFolderModal(parent_code){
    fmModalMode = "create";
    fmModalTargetParent = parent_code;
    $("#fmModalTitle").text("새 폴더");
    $("#fmModalInput").val("");
    $("#fmModalOverlay").addClass("active");
    $("#fmModalInput").focus();
}

function openFolderModalForSelected(){
    if(fmSelectedFolder == null) return;
    openFolderModal(fmSelectedFolder);
}

function openRenameModal(folder_code, currentName){
    fmModalMode = "rename";
    fmModalTargetFolder = folder_code;
    $("#fmModalTitle").text("폴더 이름변경");
    $("#fmModalInput").val(currentName);
    $("#fmModalOverlay").addClass("active");
    $("#fmModalInput").focus();
}

function renameSelectedFolder(){
    if(fmSelectedFolder == null) return;
    const f = fmFolders.find(function(x){ return x.folder_code === fmSelectedFolder; });
    if(f){ openRenameModal(f.folder_code, f.folder_name); }
}

function closeFolderModal(){
    $("#fmModalOverlay").removeClass("active");
}

function submitFolderModal(){
    const name = $("#fmModalInput").val().trim();
    if(!name){
        alert("폴더 이름을 입력하세요.");
        return;
    }

    if(fmModalMode === "create"){
        $.ajax({
            type: "POST",
            url: "/tkheat/filemanage/insertFolder",
            data: { parent_code: fmModalTargetParent, folder_name: name, reg_user: fmCurrentUser },
            success: function(){
                if(fmModalTargetParent != null){ fmExpanded[fmModalTargetParent] = true; }
                closeFolderModal();
                loadFolderTree();
            },
            error: function(){ alert("폴더 생성 중 오류가 발생했습니다."); }
        });
    }else{
        $.ajax({
            type: "POST",
            url: "/tkheat/filemanage/renameFolder",
            data: { folder_code: fmModalTargetFolder, folder_name: name },
            success: function(){
                closeFolderModal();
                loadFolderTree();
                if(fmSelectedFolder === fmModalTargetFolder){
                    updateBreadcrumb(fmSelectedFolder);
                }
            },
            error: function(){ alert("이름변경 중 오류가 발생했습니다."); }
        });
    }
}

function deleteFolder(folder_code, folder_name){
    if(!confirm('"' + folder_name + '" 폴더를 삭제하시겠습니까?\n하위 폴더와 첨부된 파일이 모두 함께 삭제됩니다.')){
        return;
    }
    $.ajax({
        type: "POST",
        url: "/tkheat/filemanage/deleteFolder",
        data: { folder_code: folder_code },
        success: function(result){
            if(result.status !== "OK"){
                alert(result.message || "삭제 중 오류가 발생했습니다.");
                return;
            }
            if(fmSelectedFolder === folder_code){
                fmSelectedFolder = null;
                $("#fmBreadcrumb").text("폴더를 선택하세요");
                $("#fmFileList").html('<div class="fm-empty-state"><div class="fm-empty-icon">🗂️</div><p>왼쪽에서 폴더를 선택하면 파일이 표시됩니다</p></div>');
                $("#fmBtnUpload, #fmBtnNewSub, #fmBtnRename, #fmBtnDelete").prop("disabled", true);
            }
            loadFolderTree();
        },
        error: function(){ alert("삭제 중 오류가 발생했습니다."); }
    });
}

function deleteSelectedFolder(){
    if(fmSelectedFolder == null) return;
    const f = fmFolders.find(function(x){ return x.folder_code === fmSelectedFolder; });
    if(f){ deleteFolder(f.folder_code, f.folder_name); }
}

/* ========================= 파일 목록/업로드/삭제 ========================= */

function loadFileList(folder_code){
    $.ajax({
        type: "POST",
        url: "/tkheat/filemanage/getFileList",
        data: { folder_code: folder_code },
        success: function(result){
            renderFileList(result || []);
        },
        error: function(){
            alert("파일 목록을 불러오는 중 오류가 발생했습니다.");
        }
    });
}

function renderFileList(files){
    const $list = $("#fmFileList");
    $list.empty();

    if(files.length === 0){
        $list.html('<div class="fm-empty-state"><div class="fm-empty-icon">📭</div><p>이 폴더에 등록된 파일이 없습니다.<br>"파일 업로드" 버튼으로 추가해보세요.</p></div>');
        return;
    }

    files.forEach(function(f){
        const row = $('<div class="fm-file-row"></div>');
        row.append('<div class="fm-file-icon">' + getFileIcon(f.original_name) + '</div>');

        const info = $('<div class="fm-file-info"></div>');
        info.append($('<div class="fm-file-name"></div>').text(f.original_name).attr("title", f.original_name));
        info.append($('<div class="fm-file-meta"></div>').text(formatFileSize(f.file_size) + " · " + f.reg_date + (f.reg_user ? " · " + f.reg_user : "")));
        row.append(info);

        const actions = $('<div class="fm-file-actions"></div>');
        const btnDown = $('<button>⬇ 다운로드</button>').on("click", function(){
            window.location.href = "/tkheat/filemanage/downloadFile?file_code=" + f.file_code;
        });
        const btnDel = $('<button class="danger">삭제</button>').on("click", function(){
            deleteFile(f.file_code, f.original_name);
        });
        actions.append(btnDown).append(btnDel);
        row.append(actions);

        $list.append(row);
    });
}

function uploadFiles(fileList){
    if(fmSelectedFolder == null) return;

    const formData = new FormData();
    formData.append("folder_code", fmSelectedFolder);
    formData.append("reg_user", fmCurrentUser);
    for(let i=0; i<fileList.length; i++){
        formData.append("files", fileList[i]);
    }

    $.ajax({
        type: "POST",
        url: "/tkheat/filemanage/uploadFile",
        data: formData,
        contentType: false,
        processData: false,
        success: function(result){
            if(result.status !== "OK"){
                alert(result.message || "업로드 중 오류가 발생했습니다.");
            }
            loadFileList(fmSelectedFolder);
            loadFolderTree();
        },
        error: function(){ alert("업로드 중 오류가 발생했습니다."); }
    });
}

function deleteFile(file_code, file_name){
    if(!confirm('"' + file_name + '" 파일을 삭제하시겠습니까?')) return;

    $.ajax({
        type: "POST",
        url: "/tkheat/filemanage/deleteFile",
        data: { file_code: file_code },
        success: function(result){
            if(result.status !== "OK"){
                alert(result.message || "삭제 중 오류가 발생했습니다.");
                return;
            }
            loadFileList(fmSelectedFolder);
            loadFolderTree();
        },
        error: function(){ alert("삭제 중 오류가 발생했습니다."); }
    });
}

/* ========================= 드래그 앤 드롭 업로드 ========================= */
$("#fmFileList").on("dragover", function(e){
    if(fmSelectedFolder == null) return;
    e.preventDefault();
    $(this).addClass("fm-dropzone-active");
});
$("#fmFileList").on("dragleave", function(e){
    $(this).removeClass("fm-dropzone-active");
});
$("#fmFileList").on("drop", function(e){
    e.preventDefault();
    $(this).removeClass("fm-dropzone-active");
    if(fmSelectedFolder == null) return;
    const dt = e.originalEvent.dataTransfer;
    if(dt && dt.files && dt.files.length > 0){
        uploadFiles(dt.files);
    }
});

/* ========================= 유틸 ========================= */

function formatFileSize(bytes){
    if(bytes == null) return "-";
    if(bytes < 1024) return bytes + " B";
    if(bytes < 1024*1024) return (bytes/1024).toFixed(1) + " KB";
    if(bytes < 1024*1024*1024) return (bytes/1024/1024).toFixed(1) + " MB";
    return (bytes/1024/1024/1024).toFixed(1) + " GB";
}

function getFileIcon(filename){
    if(!filename) return "📄";
    const ext = filename.split(".").pop().toLowerCase();
    if(["jpg","jpeg","png","gif","bmp","webp"].indexOf(ext) !== -1) return "🖼️";
    if(["pdf"].indexOf(ext) !== -1) return "📕";
    if(["xls","xlsx","csv"].indexOf(ext) !== -1) return "📗";
    if(["doc","docx"].indexOf(ext) !== -1) return "📘";
    if(["ppt","pptx"].indexOf(ext) !== -1) return "📙";
    if(["zip","rar","7z"].indexOf(ext) !== -1) return "🗜️";
    if(["txt"].indexOf(ext) !== -1) return "📝";
    return "📄";
}

function escapeHtml(str){
    if(str == null) return "";
    return String(str).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;");
}
function escapeJs(str){
    if(str == null) return "";
    return String(str).replace(/\\/g,"\\\\").replace(/'/g,"\\'");
}
</script>

</body>
</html>
